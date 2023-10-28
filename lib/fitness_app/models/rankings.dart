// To parse this JSON data, do
//
//     final rankings = rankingsFromJson(jsonString);

import 'dart:convert';

List<Rankings> rankingsFromJson(String str) =>
    List<Rankings>.from(json.decode(str).map((x) => Rankings.fromJson(x)));

String rankingsToJson(List<Rankings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rankings {
  String id;
  String name;
  String gender;
  DateTime dateOfBirth;
  String email;
  dynamic emailVerifiedAt;
  String password;
  String userType;
  dynamic pendingDailyMissions;
  dynamic pendingWeeklyMissions;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  int userPoints;

  Rankings({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
    this.emailVerifiedAt,
    required this.password,
    required this.userType,
    this.pendingDailyMissions,
    this.pendingWeeklyMissions,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.userPoints,
  });

  factory Rankings.fromJson(Map<String, dynamic> json) => Rankings(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        userType: json["userType"],
        pendingDailyMissions: json["pendingDailyMissions"],
        pendingWeeklyMissions: json["pendingWeeklyMissions"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userPoints: json["userPoints"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "userType": userType,
        "pendingDailyMissions": pendingDailyMissions,
        "pendingWeeklyMissions": pendingWeeklyMissions,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "userPoints": userPoints,
      };
}
