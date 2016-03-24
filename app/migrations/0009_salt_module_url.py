# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0008_salt_command_module'),
    ]

    operations = [
        migrations.AddField(
            model_name='salt_module',
            name='url',
            field=models.URLField(verbose_name='\u5b98\u7f51\u94fe\u63a5', blank=True),
        ),
    ]
