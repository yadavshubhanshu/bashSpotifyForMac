#!/usr/bin/env python
import sys
import json

json_data = json.load(sys.stdin)
for item in json_data['tracks']['items']:
    print "{},{},{}".format(item['name'],item['artists'][0]['name'],item['uri'])