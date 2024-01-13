// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class NotificationModel {
  int notifyID;
  int userID;
  String msg;
  int hasRead;
  String createdAt;

  NotificationModel(
      this.notifyID, this.userID, this.msg, this.hasRead, this.createdAt);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          int.parse(json["notify_id"]),
          int.parse(json["user_id"]),
          json["msg"],
          int.parse(json["hasRead"]),
          json["created_at"]);

  Map<String, dynamic> toJson() => {
        "notify_id": notifyID.toString(),
        "user_id": userID.toString(),
        "msg": msg,
        "hasRead": hasRead.toString(),
        "created_at": createdAt
      };
}
