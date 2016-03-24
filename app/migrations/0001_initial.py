# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Group',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='Host',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=30, verbose_name='\u4e3b\u673a\u540d')),
                ('ip', models.GenericIPAddressField(unique=True, verbose_name='IP\u5730\u5740')),
                ('app', models.CharField(max_length=20, verbose_name='\u529f\u80fd\u8bf4\u660e')),
                ('status', models.BooleanField(verbose_name='\u4f7f\u7528\u72b6\u6001')),
                ('group', models.ManyToManyField(to='app.Group', null=True, verbose_name='\u6240\u5c3e\u7ec4', blank=True)),
            ],
        ),
        migrations.CreateModel(
            name='IDC',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=20, verbose_name='\u673a\u623f\u540d\u79f0')),
                ('type', models.CharField(max_length=10, verbose_name='\u673a\u623f\u7c7b\u578b')),
                ('ips', models.CharField(max_length=60, verbose_name='\u516c\u7f51IP\u5730\u5740')),
                ('address', models.CharField(max_length=60, verbose_name='\u673a\u623f\u5730\u5740')),
                ('contact', models.CharField(max_length=40, verbose_name='\u8054\u7cfb\u65b9\u5f0f')),
            ],
        ),
        migrations.CreateModel(
            name='Server',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=30, verbose_name='\u540d\u79f0')),
                ('ip', models.GenericIPAddressField(unique=True, verbose_name='IP\u5730\u5740')),
                ('brand', models.CharField(max_length=30, verbose_name='\u54c1\u724c')),
                ('model', models.CharField(max_length=30, verbose_name='\u578b\u53f7')),
                ('sn', models.CharField(max_length=30, verbose_name='\u5e8f\u5217\u53f7')),
                ('location', models.CharField(max_length=30, verbose_name='\u673a\u67b6\u4f4d\u7f6e')),
                ('system', models.CharField(max_length=30, verbose_name='\u7cfb\u7edf\u73af\u5883')),
                ('idc_name', models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u623f', to='app.IDC')),
            ],
        ),
        migrations.AddField(
            model_name='host',
            name='server_name',
            field=models.ForeignKey(verbose_name='\u6240\u5c5e\u670d\u52a1\u5668', to='app.Server'),
        ),
    ]
