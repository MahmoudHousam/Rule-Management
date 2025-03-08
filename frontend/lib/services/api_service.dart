// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/rule.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/rules';

  // Fetch all rules
  static Future<List<Rule>> fetchRules() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Rule.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load rules');
    }
  }

  // Create a new rule
  static Future<Rule> createRule(Rule rule) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(rule.toJson()),
    );
    if (response.statusCode == 201) {
      return Rule.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create rule');
    }
  }

  // Update a rule
  static Future<Rule> updateRule(String id, Rule rule) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(rule.toJson()),
    );
    if (response.statusCode == 200) {
      return Rule.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update rule');
    }
  }

  // Delete a rule
  static Future<void> deleteRule(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete rule');
    }
  }
}