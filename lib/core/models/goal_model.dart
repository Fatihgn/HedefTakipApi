import 'package:hedef_takip_app/core/app/enums/goal_type_enums.dart';

class GoalModel {
  final String? id;
  final String name;
  final String description;
  final int? targetValue;
  final DateTime? deadline;
  final GoalType goalType;
  final bool isCompleted;

  GoalModel( {required this.name,this.id, 
  required this.description,  this.targetValue,  this.deadline, required this.goalType, this.isCompleted = false});
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'targetValue': targetValue,
    'deadline': deadline?.toIso8601String(),
    'goalType': goalType.name,
    'isCompleted': isCompleted,
  };

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    targetValue: json['targetValue'],
    deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
    goalType: GoalType.values.firstWhere(
      (e) => e.name == json['goalType'],
      orElse: () => GoalType.habit,
    ),
    isCompleted: json['isCompleted'] ?? false,
  );
}

