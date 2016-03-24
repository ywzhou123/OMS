# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0005_auto_20160229_1059'),
    ]

    operations = [
        migrations.CreateModel(
            name='Salt_Command',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('cmd', models.CharField(unique=True, max_length=20, verbose_name='Salt\u547d\u4ee4')),
                ('info', models.TextField(max_length=200, verbose_name='\u547d\u4ee4\u8bf4\u660e')),
            ],
            options={
                'verbose_name': 'Salt\u547d\u4ee4',
                'verbose_name_plural': 'Salt\u547d\u4ee4\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='Salt_Flow',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=20, verbose_name='\u6d41\u7a0b\u540d\u79f0')),
                ('hosts', models.CharField(max_length=100, verbose_name='\u4e3b\u673a\u5217\u8868', blank=True)),
                ('info', models.TextField(max_length=200, verbose_name='\u6d41\u7a0b\u8bf4\u660e')),
            ],
            options={
                'verbose_name': 'Salt\u6d41\u7a0b',
                'verbose_name_plural': 'Salt\u6d41\u7a0b\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='Salt_Function',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=20, verbose_name='\u529f\u80fd\u540d\u79f0')),
                ('args', models.CharField(max_length=100, verbose_name='Salt\u547d\u4ee4\u53c2\u6570')),
                ('info', models.TextField(max_length=200, verbose_name='\u529f\u80fd\u8bf4\u660e')),
                ('cmd', models.ForeignKey(verbose_name='Salt\u547d\u4ee4', to='app.Salt_Command')),
                ('group', models.ManyToManyField(to='app.Group', verbose_name='\u6240\u5c5e\u7ec4', blank=True)),
            ],
            options={
                'verbose_name': 'Salt\u529f\u80fd',
                'verbose_name_plural': 'Salt\u529f\u80fd\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='Salt_Server',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('ip', models.GenericIPAddressField(verbose_name='\u670d\u52a1\u5668IP')),
                ('port', models.IntegerField(verbose_name='\u7aef\u53e3\u53f7')),
                ('user', models.CharField(max_length=20, verbose_name='\u7528\u6237\u540d')),
                ('password', models.CharField(max_length=50, verbose_name='\u5bc6\u7801')),
                ('idc', models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u623f', to='app.IDC')),
            ],
            options={
                'verbose_name': 'Salt\u670d\u52a1\u5668',
                'verbose_name_plural': 'Salt\u670d\u52a1\u5668\u5217\u8868',
            },
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='cpu_groups',
            field=models.PositiveSmallIntegerField(null=True, verbose_name='CPU\u7269\u7406\u6838\u6570', blank=True),
        ),
        migrations.AlterField(
            model_name='host_detail',
            name='cpu_nums',
            field=models.PositiveSmallIntegerField(null=True, verbose_name='CPU\u7ebf\u7a0b\u6570', blank=True),
        ),
        migrations.AddField(
            model_name='salt_flow',
            name='funs',
            field=models.ManyToManyField(to='app.Salt_Function', verbose_name='\u529f\u80fd\u5217\u8868'),
        ),
    ]
