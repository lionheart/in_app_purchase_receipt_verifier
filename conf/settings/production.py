# -*- coding: utf-8 -*-

import os
import raven
import dj_database_url

BASE = os.path.abspath(os.path.dirname(__file__))
PROJECT_ROOT = os.path.dirname(os.path.join('..', '..', os.path.abspath(__file__)))

DEBUG = 'DEBUG' in os.environ
TEMPLATE_DEBUG = DEBUG

DATABASES = {'default': dj_database_url.config()}

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '127.0.0.1:11211',
    }
}

# Uncomment if you'd like to use S3 for static file storage.
STATIC_URL = "/static/"

BASE_URL = "https://in_app_purchase_receipt_verifier.herokuapp.com"

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'OPTIONS': {
            'loaders': (
                'django.template.loaders.filesystem.Loader',
                'django.template.loaders.app_directories.Loader',
            ),
            'context_processors': [
                "django.contrib.auth.context_processors.auth",
                "django.template.context_processors.debug",
                "django.template.context_processors.media",
                'django.template.context_processors.tz',
                "django.template.context_processors.request",
                "django.contrib.messages.context_processors.messages",
                "app.processors.add_metadata"
            ],
        },
    },
]

DEFAULT_FILE_STORAGE = 'django.core.files.storage.FileSystemStorage'
STATICFILES_STORAGE = 'statictastic.backends.VersionedFileSystemStorage'

RAVEN_CONFIG = {
    'dsn': 'https://970c85a7364c42518173841479dd10c9:e640442a54334aa096630088fbfdea97@sentry.io/233717',
    # If you are using git, you can also automatically configure the
    # release based on the git info.
}

