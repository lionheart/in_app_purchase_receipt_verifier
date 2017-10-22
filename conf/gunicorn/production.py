import os
pythonpath = os.path.abspath("..")

bind = "0.0.0.0:{}".format(os.environ['PORT'])

# http://gunicorn.org/design.html#how-many-workers
workers = 3

# Supervisor needs a non-daemonized process
daemon = False

loglevel = "warning"
proc_name = "in_app_purchase_receipt_verifier-production"
worker_class = "gevent"
debug = False

django_settings = "in_app_purchase_receipt_verifier.settings"
