// lib/screens/edit_rule_screen.dart
import 'package:flutter/material.dart';
import '../models/rule.dart';
import '../services/api_service.dart';

class EditRuleScreen extends StatefulWidget {
  final Rule rule;

  const EditRuleScreen({super.key, required this.rule});

  @override
  _EditRuleScreenState createState() => _EditRuleScreenState();
}

class _EditRuleScreenState extends State<EditRuleScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dataTypeController;
  late TextEditingController _thresholdController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _dataTypeController = TextEditingController(text: widget.rule.dataType);
    _thresholdController = TextEditingController(text: widget.rule.threshold.toString());
    _weightController = TextEditingController(text: widget.rule.weight.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Rule'),
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
                    Rule updatedRule = Rule(
                      id: widget.rule.id,
                      dataType: _dataTypeController.text,
                      threshold: double.parse(_thresholdController.text),
                      weight: double.parse(_weightController.text),
                      diagnosisMultiplier: widget.rule.diagnosisMultiplier,
                    );
                    await ApiService.updateRule(widget.rule.id, updatedRule);
                    Navigator.pop(context);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}