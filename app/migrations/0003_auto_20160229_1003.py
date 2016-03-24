# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0002_auto_20160225_1410'),
    ]

    operations = [
        migrations.CreateModel(
            name='Host_Detail',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('manufacturer', models.CharField(max_length=20, verbose_name='\u5382\u5546')),
                ('productname', models.CharField(max_length=30, verbose_name='\u4ea7\u54c1\u578b\u53f7')),
                ('service_tag', models.CharField(unique=True, max_length=80, verbose_name='\u5e8f\u5217\u53f7')),
                ('cpu_model', models.CharField(max_length=50, verbose_name='CPU\u578b\u53f7')),
                ('cpu_nums', models.PositiveSmallIntegerField(verbose_name='CPU\u7ebf\u7a0b\u6570')),
                ('cpu_groups', models.PositiveSmallIntegerField(verbose_name='CPU\u7269\u7406\u6838\u6570')),
                ('mem', models.CharField(max_length=100, verbose_name='\u5185\u5b58\u5927\u5c0f')),
                ('disk', models.CharField(max_length=300, verbose_name='\u786c\u76d8\u5927\u5c0f')),
                ('hostname', models.CharField(max_length=30, verbose_name='\u4e3b\u673a\u540d')),
                ('ip', models.CharField(max_length=20, verbose_name='IP\u5730\u5740')),
                ('ip2', models.CharField(max_length=20, verbose_name='\u5176\u4ed6IP\u5730\u5740')),
                ('os', models.CharField(max_length=20, verbose_name='\u64cd\u4f5c\u7cfb\u7edf')),
            ],
            options={
                'verbose_name': '\u4e3b\u673a\u8be6\u7ec6\u4fe1\u606f',
                'verbose_name_plural': '\u4e3b\u673a\u8be6\u7ec6\u4fe1\u606f\u5217\u8868',
            },
        ),
        migrations.AlterModelOptions(
            name='group',
            options={'verbose_name': '\u4e3b\u673a\u7ec4\u4fe1\u606f', 'verbose_name_plural': '\u4e3b\u673a\u7ec4\u5217\u8868'},
        ),
        migrations.AlterModelOptions(
            name='host',
            options={'verbose_name': '\u4e3b\u673a\u5217\u8868', 'verbose_name_plural': '\u4e3b\u673a\u5217\u8868'},
        ),
        migrations.AlterModelOptions(
            name='idc',
            options={'verbose_name': '\u673a\u623f\u5217\u8868', 'verbose_name_plural': '\u673a\u623f\u5217\u8868'},
        ),
        migrations.AlterModelOptions(
            name='server',
            options={'verbose_name': '\u670d\u52a1\u5668\u5217\u8868', 'verbose_name_plural': '\u670d\u52a1\u5668\u5217\u8868'},
        ),
        migrations.AlterField(
            model_name='host',
            name='status',
            field=models.BooleanField(default=b'true', verbose_name='\u4f7f\u7528\u72b6\u6001'),
        ),
    ]
