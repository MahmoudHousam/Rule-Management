// lib/screens/create_rule_screen.dart
import 'package:flutter/material.dart';
import '../models/rule.dart';
import '../services/api_service.dart';

class CreateRuleScreen extends StatefulWidget {
  const CreateRuleScreen({super.key});

  @override
  _CreateRuleScreenState createState() => _CreateRuleScreenState();
}

class _CreateRuleScreenState extends State<CreateRuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dataTypeController = TextEditingController();
  final _thresholdController = TextEditingController();
  final _weightController = TextEditingController();
  final _diagnosisMultiplierController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Rule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _dataTypeController,
                decoration: InputDecoration(labelText: 'Data Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a data type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _thresholdController,
                decoration: InputDecoration(labelText: 'Threshold'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a threshold';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a weight';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Rule newRule = Rule(
                      id: '', // ID will be generated by the server
                      dataType: _dataTypeController.text,
                      threshold: double.parse(_thresholdController.text),
                      weight: double.parse(_weightController.text),
                      diagnosisMultiplier: {}, // Add logic for diagnosis multipliers
                    );
                    await ApiService.createRule(newRule);
                    Navigator.pop(context);
                  }
                },
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}