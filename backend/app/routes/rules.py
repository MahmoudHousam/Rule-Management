from flask import request, jsonify
from bson.objectid import ObjectId
from app import app, rules_collection

# Examples of ICD-10 condition codes
ICD10_CODES = [
    {"code": "I50.9", "description": "Heart failure, unspecified"},
    {"code": "E11", "description": "Type 2 diabetes mellitus"},
    {"code": "J45", "description": "Asthma"},
    {"code": "M54.5", "description": "Low back pain"},
    {"code": "I10", "description": "Essential (primary) hypertension"},
]


@app.route("/icd10-codes", methods=["GET"])
def get_icd10_codes():
    return jsonify(ICD10_CODES), 200


# Helper function to convert ObjectId to string
def rule_to_json(rule):
    rule["_id"] = str(rule["_id"])
    return rule


# Create a new rule
@app.route("/rules", methods=["POST"])
def create_rule():
    rule_data = request.json
    result = rules_collection.insert_one(rule_data)
    return (
        jsonify(rule_to_json(rules_collection.find_one({"_id": result.inserted_id}))),
        201,
    )


# List all rules
@app.route("/rules", methods=["GET"])
def list_rules():
    rules = list(rules_collection.find())
    return jsonify([rule_to_json(rule) for rule in rules]), 200


# Update a rule
@app.route("/rules/<rule_id>", methods=["PUT"])
def update_rule(rule_id):
    rule_data = request.json
    rules_collection.update_one({"_id": ObjectId(rule_id)}, {"$set": rule_data})
    return (
        jsonify(rule_to_json(rules_collection.find_one({"_id": ObjectId(rule_id)}))),
        200,
    )


# Delete a rule
@app.route("/rules/<rule_id>", methods=["DELETE"])
def delete_rule(rule_id):
    rules_collection.delete_one({"_id": ObjectId(rule_id)})
    return "", 204
