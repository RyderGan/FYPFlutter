// To parse this JSON data, do
//
//     final stepCounts = stepCountsFromJson(jsonString);

import 'dart:convert';

StepCounts stepCountsFromJson(String str) =>
    StepCounts.fromJson(json.decode(str));

String stepCountsToJson(StepCounts data) => json.encode(data.toJson());

class StepCounts {
  String id;
  int userId;
  int stepCounts;
  DateTime createdAt;
  DateTime updatedAt;

  StepCounts({
    required this.id,
    required this.userId,
    required this.stepCounts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StepCounts.fromJson(Map<String, dynamic> json) => StepCounts(
        id: json["id"],
        userId: json["user_id"],
        stepCounts: json["stepCounts"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "stepCounts": stepCounts,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
