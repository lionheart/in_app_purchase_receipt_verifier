import json
import logging

from django.conf import settings
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt

from lionheart.decorators import render_json
import requests

logger = logging.getLogger(__name__)

@render_json
@csrf_exempt
def verify_receipt(request):
    data = {
        'receipt-data': request.body.encode("utf-8"),
        'password': settings.APP_SPECIFIC_SHARED_SECRET
    }
    response = requests.post(settings.RECEIPT_VERIFICATION_URL, data=json.dumps(data))
    payload = response.json()
    return payload

