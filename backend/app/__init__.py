from flask import Flask
from flask_cors import CORS
from pymongo import MongoClient
from config import Config

app = Flask(__name__)
CORS(app)
app.config.from_object(Config)

client = MongoClient(app.config["MONGO_URI"])
db = client[app.config["DATABASE_NAME"]]
rules_collection = db["scrips-rules-management"]


from app.routes import rules
