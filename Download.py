import flask
import os
import csv
import json
from flask_cors import CORS,cross_origin


app = flask.Flask(__name__)
CORS(app)
app.config["DEBUG"] = True
app.config['CORS_HEADERS'] = 'Content-Type'

@app.route('/', methods=['GET'])
def home():
    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"

@app.route('/resource', methods = ['POST'])
@cross_origin()
def update_text():

   
    data =  json.loads(flask.request.data.decode('utf-8'))
    filename = '/Users/jeunard/naf-tutorial/examples/logs/logs.txt'
    if os.path.exists(filename):
        append_write = 'a' # append if already exists
    else:
        append_write = 'w' 

    csv_file = open(filename, append_write)
    rows = zip(data["name"], data["roles"],data["timestamp"],data["x"],data["y"], data["z"],data["target"], data["selection"])
    print(len(data["selection"]))
    print(len(data["name"]))
    print(len(data["roles"]))
    print(len(data["timestamp"]))
    print(len(data["x"]))
    print(len(data["y"]))
    print(len(data["z"]))
    print(len(data["target"]))
    print("ok")
    with csv_file as f:
        writer = csv.writer(f)
        print("wreiter")
        for row in rows:
            print("this is it")
            writer.writerow(row)
    f.close()

    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"


@app.route('/resource2', methods = ['POST'])
@cross_origin()
def update_text2():

   
    data =  json.loads(flask.request.data.decode('utf-8'))
    filename = '/Users/jeunard/naf-tutorial/examples/logs/logs2.txt'
    if os.path.exists(filename):
        append_write = 'a' # append if already exists
    else:
        append_write = 'w' 

    csv_file = open(filename, append_write)
    rows = zip(data["name"], data["roles"],data["timestamp"],data["x"],data["y"], data["z"],data["target"], data["selection"])
    print(len(data["selection"]))
    print(len(data["name"]))
    print(len(data["roles"]))
    print(len(data["timestamp"]))
    print(len(data["x"]))
    print(len(data["y"]))
    print(len(data["z"]))
    print(len(data["target"]))
    print("ok")
    with csv_file as f:
        writer = csv.writer(f)
        print("wreiter")
        for row in rows:
            print("this is it")
            writer.writerow(row)
    f.close()

    return "<h1>Distant Reading Archive</h1><p>This site is a prototype API for distant reading of science fiction novels.</p>"


app.run()
