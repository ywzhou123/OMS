# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0003_auto_20160229_1003'),
    ]

    operations = [
        migrations.AlterField(
            model_name='host_detail',
            name='cpu_groups',
            field=models.PositiveSmallIntegerField(null=True, verbose_name='CPU\u7269\u7406\u6838\u6570'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='cpu_model',
            field=models.CharField(max_length=50, null=True, verbose_name='CPU\u578b\u53f7'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='cpu_nums',
            field=models.PositiveSmallIntegerField(null=True, verbose_name='CPU\u7ebf\u7a0b\u6570'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='disk',
            field=models.CharField(max_length=300, null=True, verbose_name='\u786c\u76d8\u5927\u5c0f'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='hostname',
            field=models.CharField(max_length=30, null=True, verbose_name='\u4e3b\u673a\u540d'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='ip',
            field=models.GenericIPAddressField(unique=True, verbose_name='IP\u5730\u5740'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='ip2',
            field=models.GenericIPAddressField(unique=True, null=True, verbose_name='\u5176\u4ed6IP\u5730\u5740'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='manufacturer',
            field=models.CharField(max_length=20, null=True, verbose_name='\u5382\u5546'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='mem',
            field=models.CharField(max_length=100, null=True, verbose_name='\u5185\u5b58\u5927\u5c0f'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='os',
            field=models.CharField(max_length=20, null=True, verbose_name='\u64cd\u4f5c\u7cfb\u7edf'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='productname',
            field=models.CharField(max_length=30, null=True, verbose_name='\u4ea7\u54c1\u578b\u53f7'),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='service_tag',
            field=models.CharField(max_length=80, unique=True, null=True, verbose_name='\u5e8f\u5217\u53f7'),
        ),
    ]
