#encoding:utf-8
from django.conf.urls import url
from views import *

urlpatterns = [
    #基本功能URL
    url(r'^$', index, name='index'),
    url(r'^login/$',  login,name='login'),
    url(r'^logout/$', logout,name='logout'),
    url(r'^password_change/$',password_change,name='password_change'),
    url(r'^password_change_done/$', password_change_done, name='password_change_done'),
    #CMDB URL
    url(r'^cmdb_idc/$', cmdb_idc, name='cmdb_idc'),
    url(r'^cmdb_server/$', cmdb_server, name='cmdb_server'),
    url(r'^cmdb_host/$', cmdb_host, name='cmdb_host'),
    url(r'^cmdb_network/$', cmdb_network, name='cmdb_network'),
    #SALT URL
    url(r'^salt_cmd/$', salt_cmd, name='salt_cmd'),
    url(r'^salt_cmd_run/$', salt_cmd_run, name='salt_cmd_run'),
    url(r'^salt_file/$', salt_file, name='salt_file'),
    url(r'^salt_func/$', salt_func, name='salt_func'),
    url(r'^salt_flow/$', salt_flow, name='salt_flow'),
    # 以下URL为AJAX局部更新数据，不进行页面跳转
    url(r'^host_detail/(?P<host_ip>[0-9.]+)/$', cmdb_detail, name='cmdb_detail'),
    url(r'^host_list/$', host_list, name='host_list'),
    url(r'^cmd_list/$', cmd_list, name='cmd_list'),
    url(r'^salt_module/(?P<module_id>[0-9]+)/$', salt_module, name='salt_module'),
    url(r'^cmd_run_done/$', cmd_run_done, name='cmd_run_done'),
    url(r'^salt_func_list/$', salt_func_list, name='salt_func_list'),
    url(r'^salt_func_save/$', salt_func_save, name='salt_func_save'),
    url(r'^salt_file_delete/$', salt_file_delete, name='salt_file_delete'),
    url(r'^salt_file_download/(?P<file_name>.*)/$', salt_file_download, name='salt_file_download'),
]