#coding: utf-8
from django.contrib import admin

# Register your models here.
from .models import *
admin.site.register(IDC)
admin.site.register(Server)
admin.site.register(Host)
admin.site.register(Group)
admin.site.register(Host_Detail)
admin.site.register(Network)
admin.site.register(Salt_Server)
admin.site.register(Salt_Command)
admin.site.register(Salt_Function)
admin.site.register(Salt_Flow)
admin.site.register(Salt_Module)
admin.site.register(Upload)