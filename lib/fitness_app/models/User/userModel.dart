// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String email;
  int password;
  String username;
  String userNumber;
  String userType;
  String gender;
  String dateOfBirth;
  String createdAt;
  String id;

  UserModel({
    required this.email,
    required this.password,
    required this.username,
    required this.userNumber,
    required this.userType,
    required this.gender,
    required this.dateOfBirth,
    required this.createdAt,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        password: json["password"],
        username: json["username"],
        userNumber: json["userNumber"],
        userType: json["userType"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        createdAt: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": username,
        "userNumber": userNumber,
        "userType": userType,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "created_at": createdAt,
        "id": id,
      };
}
