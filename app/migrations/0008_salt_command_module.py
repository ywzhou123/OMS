# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0007_salt_module'),
    ]

    operations = [
        migrations.AddField(
            model_name='salt_command',
            name='module',
            field=models.ForeignKey(default=1, verbose_name='\u6240\u5c5e\u6a21\u5757', to='app.Salt_Module'),
            preserve_default=False,
        ),
    ]
