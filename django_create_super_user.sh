#!/bin/bash

python3 manage.py shell <<EOF
import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "django_app.settings")

import django

django.setup()

from django.contrib.auth import get_user_model

User = get_user_model()

try:
    User.objects.create_superuser('test', 'test@example.com', 'test')
except Exception:
    pass
EOF
