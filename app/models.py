#coding: utf-8
from django.db import models

# Create your models here.
class IDC(models.Model):
    name = models.CharField(max_length=20, verbose_name=u'机房名称')
    type = models.CharField(max_length=10, verbose_name=u'机房类型')
    ips = models.CharField(max_length=60, verbose_name=u'公网IP地址')
    address = models.CharField(max_length=60, verbose_name=u'机房地址')
    contact = models.CharField(max_length=40, verbose_name=u'联系方式')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'机房列表'
        verbose_name_plural = u'机房列表'

class Server(models.Model):
    name = models.CharField(max_length=30, verbose_name=u'名称')
    ip = models.GenericIPAddressField(unique=True, verbose_name=u'IP地址')
    brand = models.CharField(max_length=30, verbose_name=u'品牌')
    model = models.CharField(max_length=30, verbose_name=u'型号')
    sn = models.CharField(max_length=30, verbose_name=u'序列号')
    location = models.CharField(max_length=30, verbose_name=u'机架位置')
    system = models.CharField(max_length=30, verbose_name=u'系统环境')
    idc_name = models.ForeignKey(IDC,verbose_name=u'所属机房')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'服务器列表'
        verbose_name_plural = u'服务器列表'

class Host(models.Model):
    name = models.CharField(max_length=30, verbose_name=u'主机名')
    ip = models.GenericIPAddressField(unique=True, verbose_name=u'IP地址')
    group = models.ManyToManyField('Group',blank=True ,verbose_name=u'所属组')
    app = models.CharField(max_length=20, verbose_name=u'功能说明')
    status = models.BooleanField(default='true',verbose_name=u'使用状态')
    server_name = models.ForeignKey(Server, verbose_name=u'所属服务器')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'主机列表'
        verbose_name_plural = u'主机列表'

class Group(models.Model):
    name = models.CharField(max_length=30,unique=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'主机组信息'
        verbose_name_plural = u'主机组列表'

class Host_Detail(models.Model):
    manufacturer = models.CharField(max_length=20,blank=True, verbose_name=u'厂商')
    productname = models.CharField(max_length=30,blank=True, verbose_name=u'产品型号')
    service_tag = models.CharField(max_length=80,blank=True, unique=True, verbose_name=u'序列号')
    cpu_model = models.CharField(max_length=50,blank=True,verbose_name=u'CPU型号')
    cpu_nums = models.PositiveSmallIntegerField(blank=True,null=True,verbose_name=u'CPU线程数')
    cpu_groups = models.PositiveSmallIntegerField(null=True,blank=True,verbose_name=u'CPU物理核数')
    mem = models.CharField(max_length=100,blank=True,verbose_name=u'内存大小')
    disk = models.CharField(max_length=300,blank=True,verbose_name=u'硬盘大小')
    hostname = models.CharField(max_length=30,blank=True,verbose_name=u'主机名')
    ip = models.GenericIPAddressField(unique=True,verbose_name=u'IP地址')
    ip2 = models.GenericIPAddressField(unique=True,null=True,blank=True, verbose_name=u'其他IP地址')
    os = models.CharField(max_length=20,blank=True,verbose_name=u'操作系统')
    def __unicode__(self):
        return self.ip
    class Meta:
        verbose_name = u'主机详细信息'
        verbose_name_plural = u'主机详细信息列表'

class Network(models.Model):
    name = models.CharField(max_length=30, verbose_name=u'名称')
    brand = models.CharField(max_length=30,blank=True, verbose_name=u'品牌')
    model = models.CharField(max_length=30,blank=True, verbose_name=u'型号')
    ip_out = models.GenericIPAddressField(unique=True,null=True,blank=True,verbose_name=u'外网IP地址')
    ip_in = models.GenericIPAddressField(unique=True,null=True,blank=True, verbose_name=u'内网IP地址')
    info = models.CharField(max_length=100,blank=True, verbose_name=u'说明')
    url = models.URLField(max_length=100, blank=True,verbose_name=u'访问地址')
    idc_name = models.ForeignKey(IDC,verbose_name=u'所属机房')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'网络设备'
        verbose_name_plural = u'网络设备列表'

# saltstack功能相关
class Salt_Server(models.Model):
    idc = models.ForeignKey(IDC,verbose_name=u'所属机房')
    ip = models.GenericIPAddressField(verbose_name=u'服务器IP')
    port = models.IntegerField(verbose_name=u'端口号')
    url = models.URLField(blank=True,verbose_name=u'URL地址')
    username = models.CharField(max_length=20, verbose_name=u'用户名')
    password = models.CharField(max_length=50,verbose_name=u'密码')
    def __unicode__(self):
        return self.ip
    class Meta:
        verbose_name = u'Salt服务器'
        verbose_name_plural = u'Salt服务器列表'
#https://docs.saltstack.com/en/latest/ref/modules/all/index.html
class Salt_Module(models.Model):
    name = models.CharField(unique=True,max_length=20,verbose_name=u'Salt模块')
    info = models.TextField(max_length=200,verbose_name=u'模块说明')
    url = models.URLField(blank=True,verbose_name=u'官网链接')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'Salt模块'
        verbose_name_plural = u'Salt模块列表'

class Salt_Command(models.Model):
    cmd = models.CharField(unique=True,max_length=40,verbose_name=u'Salt命令')
    module = models.ForeignKey(Salt_Module,verbose_name=u'所属模块')
    info = models.TextField(max_length=400,verbose_name=u'命令说明')
    def __unicode__(self):
        return self.cmd
    class Meta:
        verbose_name = u'Salt命令'
        verbose_name_plural = u'Salt命令列表'

class Salt_Function(models.Model):
    name = models.CharField(max_length=20,unique=True,verbose_name=u'功能名称')
    cmd = models.ForeignKey(Salt_Command,verbose_name=u'Salt命令')
    args = models.CharField(max_length=100,blank=True,verbose_name=u'Salt命令参数')
    group = models.ManyToManyField('Group',blank=True ,verbose_name=u'所属组')
    info = models.TextField(max_length=200,blank=True,verbose_name=u'功能说明')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'Salt功能'
        verbose_name_plural = u'Salt功能列表'

class Salt_Flow(models.Model):
    name = models.CharField(max_length=20,unique=True,verbose_name=u'流程名称')
    hosts = models.CharField(max_length=100,blank=True,verbose_name=u'主机列表')
    funs = models.ManyToManyField(Salt_Function,verbose_name=u'功能列表')
    info = models.TextField(max_length=200,verbose_name=u'流程说明')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = u'Salt流程'
        verbose_name_plural = u'Salt流程列表'

class Upload(models.Model):
    username = models.CharField(max_length = 30,verbose_name=u'用户')
    headImg = models.FileField(upload_to = './upload/',verbose_name=u'文件路径')
    date = models.DateTimeField(auto_now_add=True,verbose_name=u'上传时间')
    #存放的并非用户上传的文件本身，而是文件的存放路径。
    def __unicode__(self):
        return self.headImg
    class Meta:
        verbose_name = u'文件上传'
        verbose_name_plural = u'文件上传'