# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='host',
            name='group',
            field=models.ManyToManyField(to='app.Group', verbose_name='\u6240\u5c5e\u7ec4', blank=True),
        ),
    ]
