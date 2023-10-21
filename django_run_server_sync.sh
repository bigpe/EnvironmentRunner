#!/bin/bash

touch /tmp/app-initialized

if [ "$DEBUG" = "1" ]; then \
    python3 manage.py runserver "0.0.0.0:${BACKEND_PORT:-8000}"
else \
  gunicorn -b 0.0.0.0 -p "${BACKEND_PORT:-8000}" django_app.wsgi:application
fi
