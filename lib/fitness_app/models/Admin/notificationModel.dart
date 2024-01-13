// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class NotificationModel {
  int id;
  int user_id;
  String msg;
  int hasRead;
  String createdAt;

  NotificationModel(
    this.id,
    this.user_id,
    this.msg,
    this.hasRead,
    this.createdAt,
  );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        int.parse(json["notify_id"]),
        int.parse(json["user_id"]),
        json["msg"],
        int.parse(json["hasRead"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "notify_id": id.toString(),
        "user_id": user_id.toString(),
        "msg": msg,
        "hasRead": hasRead.toString(),
        "created_at": createdAt,
      };
}
