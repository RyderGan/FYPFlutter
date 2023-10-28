// To parse this JSON data, do
//
//     final visceralFats = visceralFatsFromJson(jsonString);

import 'dart:convert';

VisceralFats visceralFatsFromJson(String str) =>
    VisceralFats.fromJson(json.decode(str));

String visceralFatsToJson(VisceralFats data) => json.encode(data.toJson());

class VisceralFats {
  String id;
  int userId;
  int visceralFat;
  DateTime createdAt;
  DateTime updatedAt;

  VisceralFats({
    required this.id,
    required this.userId,
    required this.visceralFat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VisceralFats.fromJson(Map<String, dynamic> json) => VisceralFats(
        id: json["id"],
        userId: json["user_id"],
        visceralFat: json["visceralFat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "visceralFat": visceralFat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
