// To parse this JSON data, do
//
//     final bloodPressures = bloodPressuresFromJson(jsonString);

import 'dart:convert';

BloodPressures bloodPressuresFromJson(String str) =>
    BloodPressures.fromJson(json.decode(str));

String bloodPressuresToJson(BloodPressures data) => json.encode(data.toJson());

class BloodPressures {
  String id;
  int userId;
  String bloodPressure;
  DateTime createdAt;
  DateTime updatedAt;

  BloodPressures({
    required this.id,
    required this.userId,
    required this.bloodPressure,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BloodPressures.fromJson(Map<String, dynamic> json) => BloodPressures(
        id: json["id"],
        userId: json["user_id"],
        bloodPressure: json["bloodPressure"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bloodPressure": bloodPressure,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
