# -*- coding: utf-8 -*-
from django.shortcuts import get_object_or_404, render,render_to_response
from django.http import HttpResponseRedirect,HttpResponse,JsonResponse
from django.core.urlresolvers import reverse
from django.core import serializers
from django.contrib import auth
from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import  PasswordChangeForm
from .models import *
import ConfigParser
import rpyc
import json
from django import forms
from django.http import StreamingHttpResponse
import os

#######################################################################################################################
#基础模块：登陆、登出、改密、欢迎页
def login(request):
    username = request.POST.get('username','')
    password = request.POST.get('password','')
    user = auth.authenticate(username=username, password=password)
    if user is not None and user.is_active:
        auth.login(request, user)
        return redirect('app:index')
    else:
        return render(request,'login.html')
def logout(request):
    auth.logout(request)
    return render(request,'logout.html')
@login_required
def password_change(request):
    if request.method == 'POST':
        form = PasswordChangeForm(user=request.user, data=request.POST)
        if form.is_valid():
            form.save()
            update_session_auth_hash(request, form.user)
            return HttpResponseRedirect(reverse('app:password_change_done'))
    else:
        form = PasswordChangeForm(user=request.user)
    return render(request, 'password_change.html', {'form':form})
@login_required
def password_change_done(request):
    return render(request, 'password_change_done.html')
#欢迎首页
@login_required
def index(request):
    return render(request, 'index.html')
#######################################################################################################################
# CMDB模块:数据可以admin后台增删改，因此这里只需要展示，加一个操作按钮跳转到admin后台
#机房列表
@login_required
def cmdb_idc(request):
    idc_list= IDC.objects.order_by('pk')
    context = {'idc_list':idc_list}
    return render(request, 'cmdb_idc.html', context)
#服务器列表
@login_required
def cmdb_server(request):
    server_list= Server.objects.order_by('ip')
    context = {'server_list':server_list}
    return render(request, 'cmdb_server.html', context)
#主机列表
@login_required
def cmdb_host(request):
    host_list= Host.objects.order_by('ip')
    context = {'host_list':host_list}
    return render(request, 'cmdb_host.html', context)
#主机详细信息
@login_required
def cmdb_detail(request,host_ip):
    Host_Detail.objects.get_or_create(ip = host_ip)
    host_detail = Host_Detail.objects.get(ip=host_ip)
    return render(request, 'cmdb_detail.html', {'host_detail': host_detail})
#网络设备列表
@login_required
def cmdb_network(request):
    net_list = Network.objects.all()
    return render(request,'cmdb_network.html',{'net_list':net_list})
#######################################################################################################################
#SALT模块：通过salt-api执行命令
#手动操作页面：只传输了部分列表数据，其他数据通过AJAX异步过滤传输，不刷新页面
#rpyc client程序，与服务端通过JSON通讯
def cmd_run(idc,hosts,cmd,args):
    salt_server = Salt_Server.objects.get(idc=idc) #根据机房ID选择对应salt服务端
    try:
        conn = rpyc.connect(salt_server.ip,salt_server.port)
        conn.root.login(salt_server.user,salt_server.password)
    # try:
    #     conn=rpyc.connect('10.188.1.40',11511)
    #     conn.root.login('OMuser','KJS23o4ij09gHF734iuhsdfhkGYSihoiwhj38u4h')
    except Exception,e:
        return ('connect rpyc server error:'+str(e))
    d = {'hosts':hosts,'cmd':cmd,'args':args}
    j = json.dumps(d) #字典转化成json字符串
    r = conn.root.cmd(j) #rpyc只能传送字符串，不能传字典
    if r == "{}": #返回的是个空json字符串，后台会显示以下ERROR，即没有目标可达
        result = {"ERROR":"No minions matched the target. No command was sent. no jid was assigned."}
        #JSON格式必须用双引号，这里我开始用单引号结果WEB不显示，另外最好也不要使用逗号
    else:
        result = json.loads(r)
        # result = json.loads(r,"gbk") #gbk解决中文解码问题
        # result = r
    return result
#运行命令：AJAX获取页面参数，调用cmd_run()与后台通讯
def cmd_run_done(request):
    if request.is_ajax():
        if request.method == 'GET':
            idc = str(request.GET.get('idc',''))
            hosts = str(request.GET.get('hosts'))
            cmd =str(request.GET.get('cmd',''))
            args = str(request.GET.get('args',''))
            result = cmd_run(idc,hosts,cmd,args)
            print result
            print type(result)
            return JsonResponse(result)
#主机列表：前端使用AJAX技术获取级联菜单，根据选择的机房返回对应主机列表
def host_list(request):
    if request.is_ajax():
        if request.method == 'GET':
            idc_id = request.GET.get('idc_id')
            group_ids = request.GET.get('group_ids')
            host_list = []
            if idc_id:
                if group_ids:
                    group_list = group_ids.split(',')
                    idc = get_object_or_404(IDC, pk=idc_id)
                    server_list = idc.server_set.all()
                    for server in server_list:
                        for host in server.host_set.all():
                            host_group = []
                            for group in  host.group.all():
                                host_group.append(group.name)
                            #用集合的方式判断主机所属组包含了所有选择的组过滤选项
                            if set(group_list).issubset(set(host_group)):
                                host_list.append(host.name)
                else:
                    idc = get_object_or_404(IDC, pk=idc_id)
                    server_list = idc.server_set.all()
                    for server in server_list:
                        for host in server.host_set.all():
                            host_list.append(host.name)
            else:
                host_list =['请选择机房!!!'] #此处无效，前端js作了alert处理
            return JsonResponse(host_list,safe=False)
#命令列表：前端使用AJAX技术获取级联菜单，根据选择的机房返回对应主机列表
def cmd_list(request):
    if request.is_ajax():
        if request.method == 'GET':
            module_id = request.GET.get('module_id')
        # else:
        #     idc_id = 3
            module = get_object_or_404(Salt_Module, pk=module_id)
            cmds = module.salt_command_set.all().order_by('-cmd')
            cmd_list = []
            for cmd in cmds:
                cmd_list.append(cmd.cmd)
            return JsonResponse(cmd_list,safe=False)
#命令配置页面：
@login_required
def salt_cmd(request):
    module_list=Salt_Module.objects.order_by('name')
    return render(request, 'salt_cmd.html', locals())
#指定模块所含命令列表：
@login_required
def salt_module(request, module_id):
    module = get_object_or_404(Salt_Module, pk=module_id)
    cmd_list = module.salt_command_set.all().order_by('-cmd')
    return render(request, 'salt_module.html', locals())
@login_required
def salt_cmd_run(request):
    idc_list = IDC.objects.order_by('id')
    group_list = Group.objects.order_by('name')
    # cmd_list = Salt_Command.objects.order_by('cmd')
    module_list = Salt_Module.objects.order_by('name')
    return  render(request, 'salt_cmd_run.html', locals())
#功能添加到数据库
def salt_func_save(request):
    if request.is_ajax():
        if request.method == 'GET':
            name = request.GET.get('name')
            cmd = request.GET.get('cmd')
            cmd_id = Salt_Command.objects.get(cmd=cmd).id
            args = request.GET.get('args')
            info = request.GET.get('info')
            if Salt_Function.objects.filter(name=name).exists():
                return JsonResponse(False,safe=False)
            else:
                Salt_Function.objects.create(cmd_id=cmd_id,name=name,args=args,info=info)
                return JsonResponse(True,safe=False)
@login_required
def salt_func_list(request):
    pass
def salt_func(request):
    pass
def salt_flow(request):
    pass
#######################################################################################################################
#文件管理相关：显示、上传、下载、删除、推送、拉取
class UploadForm(forms.Form): #django自带的上传表单
    headImg = forms.FileField()
@login_required
def salt_file(request):
   file_list = Upload.objects.order_by('-date')
   idc_list = IDC.objects.order_by('id')
   group_list = Group.objects.order_by('name')
   if request.method == "POST":
       result=salt_file_upload(request)
       msg=result['msg']
       ok=result['ok']
   return render(request, 'salt_file.html', locals())
def salt_file_upload(request):
    uf = UploadForm(request.POST,request.FILES)
    if uf.is_valid():
        #获取表单信息
        username = request.user.username
        headImg = uf.cleaned_data['headImg']
        #写入数据库
        user = Upload()
        user.username = username
        user.headImg = headImg
        try :
            user.save()
            result = {'msg':'文件 "%s" 上传成功！ 请不要刷新页面，否则会重复上传！' % headImg,'ok':'yes'}
        except Exception as err:
            result = {'msg':err,'ok':'no'}
        return result
def salt_file_download(request, file_name):
    import sys
    reload(sys)
    sys.setdefaultencoding('utf-8') #解决中文字符默认使用ascii编码问题，不用管得示not find，reload后自然就有了
    def file_iterator(file, chunk_size=512):
        with open(file) as f:
            while True:
                c = f.read(chunk_size)
                if c:
                    yield c
                else:
                    break
        f.close()
    response = StreamingHttpResponse(file_iterator(file_name))
    #为了可以下载任意类型文件
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="{0}"'.format(file_name)
    return response
def salt_file_delete(request):
    if request.is_ajax():
        if request.method == 'GET':
            file_id = str(request.GET.get('file_id'))
            print file_id
            file = Upload.objects.get(pk=file_id)
            sname = str(file.headImg)
            uname = unicode(sname,"utf8")       #删除中文名称的文件需要使用utf8编码
            try:
                if os.path.exists(uname):
                    os.remove(uname)
                file.delete()
                msg = '文件 "%s" 删除成功！' % sname
            except object as err:
                msg = err
                print err
            return HttpResponse(msg)
def file_push(request):
    pass
def file_pull(request):
    pass