// To parse this JSON data, do
//
//     final bmis = bmisFromJson(jsonString);

import 'dart:convert';

Bmis bmisFromJson(String str) => Bmis.fromJson(json.decode(str));

String bmisToJson(Bmis data) => json.encode(data.toJson());

class Bmis {
  String id;
  int userId;
  int bmi;
  DateTime createdAt;
  DateTime updatedAt;

  Bmis({
    required this.id,
    required this.userId,
    required this.bmi,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bmis.fromJson(Map<String, dynamic> json) => Bmis(
        id: json["id"],
        userId: json["user_id"],
        bmi: json["bmi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "bmi": bmi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
