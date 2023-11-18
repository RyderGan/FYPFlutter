// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class FeedbackModel {
  int userID;
  String title;
  String description;
  String createdAt;

  FeedbackModel(this.userID, this.title, this.description, this.createdAt);

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        int.parse(json["user_id"]),
        json["title"],
        json["fb_description"],
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userID.toString(),
        "title": title,
        "fb_description": description,
        "created_at": createdAt,
      };
}
