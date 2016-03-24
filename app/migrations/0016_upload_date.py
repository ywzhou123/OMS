# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0015_upload'),
    ]

    operations = [
        migrations.AddField(
            model_name='upload',
            name='date',
            field=models.DateTimeField(default=datetime.datetime(2016, 3, 17, 1, 56, 43, 514000, tzinfo=utc), verbose_name='\u4e0a\u4f20\u65f6\u95f4', auto_now_add=True),
            preserve_default=False,
        ),
    ]
