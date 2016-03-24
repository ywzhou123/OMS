# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0010_auto_20160314_1520'),
    ]

    operations = [
        migrations.CreateModel(
            name='Network',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=30, verbose_name='\u540d\u79f0')),
                ('brand', models.CharField(max_length=30, verbose_name='\u54c1\u724c', blank=True)),
                ('model', models.CharField(max_length=30, verbose_name='\u578b\u53f7', blank=True)),
                ('info', models.CharField(max_length=30, verbose_name='\u8bf4\u660e', blank=True)),
                ('url', models.URLField(max_length=30, verbose_name='\u8bbf\u95ee\u5730\u5740', blank=True)),
                ('username', models.CharField(max_length=30, verbose_name='\u7528\u6237\u540d', blank=True)),
                ('password', models.CharField(max_length=30, verbose_name='\u5bc6\u7801', blank=True)),
                ('idc_name', models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u623f', to='app.IDC')),
            ],
            options={
                'verbose_name': '\u7f51\u7edc\u8bbe\u5907',
                'verbose_name_plural': '\u7f51\u7edc\u8bbe\u5907\u5217\u8868',
            },
        ),
    ]
