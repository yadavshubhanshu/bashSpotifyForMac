#!/usr/bin/env python
import sys
import json

def codeit(x):
    return x.encode('utf-8')

json_data = json.load(sys.stdin)
for item in json_data['tracks']['items']:
    name = codeit(item['name'])
    artist = codeit(item['artists'][0]['name'])
    uri = codeit(item['uri'])
    print "{},{},{}".format(name,artist,uri)
