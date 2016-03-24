# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0013_auto_20160315_1425'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='network',
            name='password',
        ),
        migrations.RemoveField(
            model_name='network',
            name='username',
        ),
    ]
