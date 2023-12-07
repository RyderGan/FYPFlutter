// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class FeedbackModel {
  int feedbackID;
  int userID;
  String title;
  String description;

  FeedbackModel(this.feedbackID, this.userID, this.title, this.description);

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        int.parse(json["feedback_id"]),
        int.parse(json["user_id"]),
        json["title"],
        json["fb_description"],
      );

  Map<String, dynamic> toJson() => {
        "feedback_id": feedbackID.toString(),
        "user_id": userID.toString(),
        "title": title,
        "fb_description": description,
      };
}
