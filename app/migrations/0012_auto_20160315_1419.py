# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0011_network'),
    ]

    operations = [
        migrations.AlterField(
            model_name='network',
            name='info',
            field=models.CharField(max_length=100, verbose_name='\u8bf4\u660e', blank=True),
        ),
        migrations.AlterField(
            model_name='network',
            name='url',
            field=models.URLField(max_length=100, verbose_name='\u8bbf\u95ee\u5730\u5740', blank=True),
        ),
    ]
