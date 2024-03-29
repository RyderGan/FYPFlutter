// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class UserModel {
  int id;
  String email;
  String password;
  String fullName;
  String userType;
  String gender;
  String dateOfBirth;
  int rewardPoint;
  String createdAt;

  UserModel(this.id, this.email, this.password, this.fullName, this.userType,
      this.gender, this.dateOfBirth, this.rewardPoint, this.createdAt);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        int.parse(json["id"]),
        json["email"],
        json["user_password"],
        json["full_name"],
        json["user_type"],
        json["gender"],
        json["dateOfBirth"],
        int.parse(json["reward_point"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "email": email,
        "user_password": password,
        "full_name": fullName,
        "user_type": userType,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "reward_point": rewardPoint.toString(),
        "created_at": createdAt,
      };
}
