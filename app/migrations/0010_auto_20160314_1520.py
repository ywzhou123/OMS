# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0009_salt_module_url'),
    ]

    operations = [
        migrations.AlterField(
            model_name='salt_command',
            name='cmd',
            field=models.CharField(unique=True, max_length=40, verbose_name='Salt\u547d\u4ee4'),
        ),
        migrations.AlterField(
            model_name='salt_command',
            name='info',
            field=models.TextField(max_length=400, verbose_name='\u547d\u4ee4\u8bf4\u660e'),
        ),
        migrations.AlterField(
            model_name='salt_function',
            name='args',
            field=models.CharField(max_length=100, verbose_name='Salt\u547d\u4ee4\u53c2\u6570', blank=True),
        ),
        migrations.AlterField(
            model_name='salt_function',
            name='info',
            field=models.TextField(max_length=200, verbose_name='\u529f\u80fd\u8bf4\u660e', blank=True),
        ),
    ]
