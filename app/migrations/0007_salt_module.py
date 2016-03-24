# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0006_auto_20160309_0918'),
    ]

    operations = [
        migrations.CreateModel(
            name='Salt_Module',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=20, verbose_name='Salt\u6a21\u5757')),
                ('info', models.TextField(max_length=200, verbose_name='\u6a21\u5757\u8bf4\u660e')),
            ],
            options={
                'verbose_name': 'Salt\u6a21\u5757',
                'verbose_name_plural': 'Salt\u6a21\u5757\u5217\u8868',
            },
        ),
    ]
