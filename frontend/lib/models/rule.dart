// lib/models/rule.dart
class Rule {
  final String id;
  final String dataType;
  final double threshold;
  final double weight;
  final Map<String, double> diagnosisMultiplier;

  Rule({
    required this.id,
    required this.dataType,
    required this.threshold,
    required this.weight,
    required this.diagnosisMultiplier,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      id: json['_id'],
      dataType: json['data_type'],
      threshold: json['threshold'].toDouble(),
      weight: json['weight'].toDouble(),
      diagnosisMultiplier: Map<String, double>.from(json['diagnosis_multiplier']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data_type': dataType,
      'threshold': threshold,
      'weight': weight,
      'diagnosis_multiplier': diagnosisMultiplier,
    };
  }
}