import json
import logging
import base64

from django.conf import settings
from django.shortcuts import get_object_or_404
from django.views.decorators.csrf import csrf_exempt

from lionheart.decorators import render_json
from lionheart.utils import JSONResponse
import requests

from Crypto.PublicKey import RSA
from Crypto.Signature import PKCS1_v1_5
from Crypto.Hash import SHA256
from Crypto import Random

logger = logging.getLogger(__name__)

@csrf_exempt
def verify_receipt(request):
    data = {
        'receipt-data': request.body.strip().decode("utf-8"),
        'password': settings.APP_SPECIFIC_SHARED_SECRET
    }
    response = requests.post(settings.RECEIPT_VERIFICATION_URL, data=json.dumps(data))
    payload = response.json()
    response = JSONResponse(payload)

    # If signing key is available, sign the payload to detect potential tampering.
    if settings.BASE64_ENCODED_SIGNING_KEY:
        key_data = base64.b64decode(settings.BASE64_ENCODED_SIGNING_KEY)
        key = RSA.importKey(key_data)

        data = json.dumps(payload).encode("utf8")

        digest = SHA256.new()
        digest.update(data)

        use_salt = False
        if use_salt:
            rndfile = Random.new()
            salt_data = rndfile.read(64)
            salt = base64.b64encode(nonce_data)

            digest.update(salt_data)
            response['X-Salt'] = nonce

        signer = PKCS1_v1_5.new(key)
        signature = signer.sign(digest)
        response['X-Signature'] = base64.b64encode(signature)

    return response

