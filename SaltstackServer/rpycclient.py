#!/usr/bin/python
#coding:utf-8

import rpyc
import json

def cmd_run(idc,hosts,cmd,args):
    try:
        conn=rpyc.connect('10.188.1.40',11511) #连接服务端
        conn.root.login('OMuser','KJS23o4ij09gHF734iuhsdfhkGYSihoiwhj38u4h') #登陆账号密码
    except Exception,e:
        return ('connect rpyc server error:'+str(e)) #返回错误

    d = {'hosts':hosts,'cmd':cmd,'args':args}
    j = json.dumps(d)
    r=conn.root.cmd(j)

    if r == "{}":
        result = {'ERROR':'No minions matched the target. No command was sent, no jid was assigned.'}
    else:
        result = json.loads(r,"gbk")
    return result

c=cmd_run(3,"saltminion01-41.ewp.com","test.ping","")
# c=cmd_run(3,u"saltminion01-41.ewp.com",u"service.get_all",u"")
# c=cmd_run(3,u"saltminion02-42",u"cmd.run",u"dir c:\\")

print type(c)
print c