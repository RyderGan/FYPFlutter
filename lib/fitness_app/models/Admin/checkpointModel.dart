// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class CheckpointModel {
  int cp_id;
  int check_point;
  int road_id;
  String createdAt;

  CheckpointModel(this.cp_id, this.check_point, this.road_id, this.createdAt);

  factory CheckpointModel.fromJson(Map<String, dynamic> json) =>
      CheckpointModel(
        int.parse(json["cp_id"]),
        int.parse(json["check_point"]),
        int.parse(json["road_id"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "cp_id": cp_id.toString(),
        "check_point": check_point.toString(),
        "road_id": road_id.toString(),
        "created_at": createdAt,
      };
}
