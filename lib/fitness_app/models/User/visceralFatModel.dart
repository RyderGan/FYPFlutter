// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class VisceralFatModel {
  int vfID;
  int userID;
  int rating;
  String createdAt;

  VisceralFatModel(this.vfID, this.userID, this.rating, this.createdAt);

  factory VisceralFatModel.fromJson(Map<String, dynamic> json) =>
      VisceralFatModel(
        int.parse(json["vf_id"]),
        int.parse(json["user_id"]),
        int.parse(json["rating"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "vf_id": vfID.toString(),
        "user_id": userID.toString(),
        "rating": rating.toString(),
        "created_at": createdAt,
      };
}
