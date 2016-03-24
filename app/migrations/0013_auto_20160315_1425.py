# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0012_auto_20160315_1419'),
    ]

    operations = [
        migrations.AddField(
            model_name='network',
            name='ip_in',
            field=models.GenericIPAddressField(unique=True, null=True, verbose_name='\u5185\u7f51IP\u5730\u5740', blank=True),
        ),
        migrations.AddField(
            model_name='network',
            name='ip_out',
            field=models.GenericIPAddressField(unique=True, null=True, verbose_name='\u5916\u7f51IP\u5730\u5740', blank=True),
        ),
    ]
