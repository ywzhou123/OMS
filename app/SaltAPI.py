#!/usr/bin/env python
#coding=utf-8

import urllib2, urllib, json

#Python 2.7.9 之后版本引入了一个新特性
#当你urllib.urlopen一个 https 的时候会验证一次 SSL 证书
#当目标使用的是自签名的证书时就会爆出一个
#urllib.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:581)> 的错误消息，
import ssl
ssl._create_default_https_context = ssl._create_unverified_context


class SaltAPI:
    def __init__(self,url,username,password):
        self.__url = url.rstrip('/') #移除URL末尾的/
        self.__username = username
        self.__password = password
        self.__token_id = self.SaltLogin()
    #登陆获取token
    def SaltLogin(self):
        params = {'eauth': 'pam', 'username': self.__username, 'password': self.__password}
        encode = urllib.urlencode(params)
        obj = urllib.unquote(encode)
        headers = {'X-Auth-Token':''}
        url = self.__url + '/login'
        req = urllib2.Request(url, obj, headers)
        opener = urllib2.urlopen(req)
        content = json.loads(opener.read())
        try:
            token = content['return'][0]['token']
            #3489c6508041569a102f25bd09bf9072a1152bcb
            return token
        except KeyError:
            raise KeyError
    #推送请求
    def PostRequest(self, obj, prefix='/'):
        url = self.__url + prefix
        headers = {'X-Auth-Token': self.__token_id}
        req = urllib2.Request(url,obj, headers)  # obj为传入data参数字典，data为None 则方法为get，有date为post方法
        opener = urllib2.urlopen(req)
        content = json.loads(opener.read())
        return content

    #将接收的参数通过推送请求获取命令执行结果
    #如 params = {'client':'local', 'fun':'test.ping', 'tgt':'*'}
    #如 params = {'client': 'local_async', 'tgt': tgt, 'fun': 'state.sls', 'arg': arg, 'expr_form': 'nodegroup'}
    def SaltRun(self, params,prefix='/'):
        if params:
            obj = urllib.urlencode(params)
        else:
            obj = None
        res = self.PostRequest(obj,prefix)
        return res
    #获取JOB ID的详细执行结果
    def SaltJob(self,jid):
        params = {'client':'runner', 'fun':'jobs.lookup_jid', 'jid': jid}
        res = self.SaltRun(params)
        return res
    #异步命令，仅返回jid和minions
    def SaltCmd(self,tgt,fun,arg='',client='local_async',expr_form='list'):
        if arg:
            params = {'client':client, 'fun':fun, 'tgt':tgt, 'arg':arg,'expr_form':expr_form}
        else:
            params = {'client':client, 'fun':fun, 'tgt':tgt, 'expr_form':expr_form}
        res=self.SaltRun(params)
        return res
        #{u'return': [{u'jid': u'20160331104340284003', u'minions': [u'saltminion01-41.ewp.com']}]}

    #获取grains
    def SaltMinions(self,minion=''):
        if minion:
            prefix = '/minions/'+minion
        else:
            prefix = '/minions'
        params = {}
        res = self.SaltRun(params,prefix)
        return res


#     #以下是用来测试saltAPI类的部分，直接运行该脚本就行
# def main():
#     sapi = SaltAPI(url='https://10.188.1.40:8000',username='salt',password='salt')
#     print sapi.salt_login()
#     params = {'client':'local', 'fun':'test.ping', 'tgt':'*'}
#     #params = {'client':'local', 'fun':'test.ping', 'tgt':'某台服务器的key'}
#     #params = {'client':'local', 'fun':'test.echo', 'tgt':'某台服务器的key', 'arg':'hello'}
#     #params = {'client':'local', 'fun':'test.ping', 'tgt':'某组服务器的组名', 'expr_form':'nodegroup'}
#     test = sapi.saltCmd(params)
#     print test,type(test)



#测试：python manager.py shell ; from app.SaltAPI import * ; main()，代码修改了要ctrl+Z退出重进
def main():
    idc = '3'
    tgt = 'saltminion01-41.ewp.com,saltminion02-42'
    fun ='test.ping'
    arg = None
    from models import Salt_Server
    salt_server = Salt_Server.objects.get(idc=idc) #根据机房ID选择对应salt服务端
    sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
    result = sapi.SaltCmd(tgt=tgt,fun=fun)
    minions= sapi.SaltMinions(result['return'][0]['minions'][1])
    print minions
    jid = result['return'][0]['jid']
    print jid
    jidinfo=sapi.SaltJob(jid)
    print jidinfo
    return (result)


if __name__ == '__main__':
    main()