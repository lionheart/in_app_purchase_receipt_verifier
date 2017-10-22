bind = "0.0.0.0:8000"
workers = 3
daemon = False
loglevel = "debug"
proc_name = "in_app_purchase_receipt_verifier"
pidfile = "/tmp/in_app_purchase_receipt_verifier.pid"
worker_class = "gevent"
debug = True
django_settings = "in_app_purchase_receipt_verifier.settings"

