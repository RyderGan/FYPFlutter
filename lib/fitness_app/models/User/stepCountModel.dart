// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class StepCountModel {
  int stepCount_id;
  int user_id;
  int stepCount;
  String createdAt;

  StepCountModel(
      this.stepCount_id, this.user_id, this.stepCount, this.createdAt);

  factory StepCountModel.fromJson(Map<String, dynamic> json) => StepCountModel(
        int.parse(json["stepCount_id"]),
        int.parse(json["user_id"]),
        int.parse(json["stepCount"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "stepCount_id": stepCount_id.toString(),
        "user_id": user_id.toString(),
        "stepCount": stepCount.toString(),
        "created_at": createdAt,
      };
}
