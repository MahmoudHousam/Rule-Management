// lib/widgets/rule_list_item.dart
import 'package:flutter/material.dart';
import '../models/rule.dart';

class RuleListItem extends StatelessWidget {
  final Rule rule;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const RuleListItem({super.key, 
    required this.rule,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(rule.dataType),
      subtitle: Text('Threshold: ${rule.threshold}, Weight: ${rule.weight}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}