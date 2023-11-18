// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class BmiModel {
  int bmiID;
  int userID;
  int weight;
  int height;
  String createdAt;

  BmiModel(this.bmiID, this.userID, this.weight, this.height, this.createdAt);

  factory BmiModel.fromJson(Map<String, dynamic> json) => BmiModel(
        int.parse(json["bmi_id"]),
        int.parse(json["user_id"]),
        int.parse(json["user_weight"]),
        int.parse(json["user_height"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "bmi_id": bmiID.toString(),
        "user_id": userID.toString(),
        "user_weight": weight.toString(),
        "user_height": height.toString(),
        "created_at": createdAt,
      };
}
