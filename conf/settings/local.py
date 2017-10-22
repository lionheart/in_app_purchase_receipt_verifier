import os

BASE = os.path.abspath(os.path.dirname(__name__))

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'in_app_purchase_receipt_verifier_local',
        'USER': 'in_app_purchase_receipt_verifier_local',
        'PASSWORD': 'in_app_purchase_receipt_verifier_local',
        'HOST': '127.0.0.1',
        'PORT': '5432'
    }
}

CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'in_app_purchase_receipt_verifier'
    }
}

RAVEN_CONFIG = {
    'dsn': ""
}

# Uncomment if you'd like to use S3 for local file storage.
# DEFAULT_FILE_STORAGE = 'storages.backends.s3boto.S3BotoStorage'
DEFAULT_FILE_STORAGE = 'django.core.files.storage.FileSystemStorage'

STATICFILES_STORAGE = 'statictastic.backends.VersionedFileSystemStorage'

STATIC_URL = "/static/"

EMAIL_BACKEND = 'django.core.mail.backends.filebased.EmailBackend'
EMAIL_FILE_PATH = '/tmp/app-messages'

BASE_URL = "http://local.in_app_purchase_receipt_verifier.com"

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE, "templates"),
        ],
        'OPTIONS': {
            'debug': True,
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
            ],
        },
    },
]

