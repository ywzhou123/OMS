#!/usr/bin/python
#coding:utf-8

# 在saltstack服务器上运行此传输层服务端进程
# yum -y install python rpycserver salt-api
# pip install salt
from rpyc import Service
from rpyc.utils.server import ThreadedServer
import json
import salt.client

class ManagerService(Service):
    #rpyc只传送exposed_开头的函数
    #进行连接用户认证
    def exposed_login(self,user,passwd):
        if user=="OMuser" and passwd=="KJS23o4ij09gHF734iuhsdfhkGYSihoiwhj38u4h":
            self.Checkout_pass=True
        else:
            self.Checkout_pass=False
    #认证成功后执行接收到的命令关返回结果
    def exposed_cmd(self,command):
        try:
            if self.Checkout_pass!=True:
                return "User verify failed!"
        except:
            return "Invalid Login!"

        d = json.loads(command)
        hosts = d['hosts']
        cmd = d['cmd']
        args = d['args'].split(',')

        client = salt.client.LocalClient()
        try:
            if d['args']:
                r = client.cmd(hosts,cmd,args)
            else:
                r = client.cmd(hosts,cmd)
        except:
            r = {'error':'No minions matched the target. No command was sent, no jid was assigned.'}
        result = json.dumps(r,ensure_ascii=False) #关闭ascii编码，解决中文问题
        return result

#启动进程服务
s=ThreadedServer(ManagerService,port=11511,auto_register=False)
s.start()
