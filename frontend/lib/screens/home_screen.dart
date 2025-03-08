// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/rule.dart';
import '../services/api_service.dart';
import 'create_rule_screen.dart';
import 'edit_rule_screen.dart';
import '../widgets/rule_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Rule>> futureRules;

  @override
  void initState() {
    super.initState();
    futureRules = ApiService.fetchRules();
  }

  void _refreshRules() {
    setState(() {
      futureRules = ApiService.fetchRules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rule Management'),
      ),
      body: FutureBuilder<List<Rule>>(
        future: futureRules,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No rules found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Rule rule = snapshot.data![index];
                return RuleListItem(
                  rule: rule,
                  onEdit: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRuleScreen(rule: rule),
                      ),
                    );
                    _refreshRules();
                  },
                  onDelete: () async {
                    await ApiService.deleteRule(rule.id);
                    _refreshRules();
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRuleScreen()),
          );
          _refreshRules();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}