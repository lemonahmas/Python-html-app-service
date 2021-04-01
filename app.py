from flask import Flask
import pyodbc

app = Flask(__name__)

@app.route("/")
def hello():
    with open("./index.html","r") as f:
        res = f.read()
    return res
