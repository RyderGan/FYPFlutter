// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class PathModel {
  int path_id;
  String path_name;
  List<int> path_checkpoint_list;
  int path_distance;
  int path_elevation;
  int path_difficulty;
  int time_limit;
  int path_points;
  String path_type;

  PathModel(
      this.path_id,
      this.path_name,
      this.path_checkpoint_list,
      this.path_distance,
      this.path_elevation,
      this.path_difficulty,
      this.time_limit,
      this.path_points,
      this.path_type);

  factory PathModel.fromJson(Map<String, dynamic> json) => PathModel(
        int.parse(json["path_id"]),
        json["path_name"],
        json["path_checkpoint_list"]
            .split(",")
            .map(int.parse)
            .toList()
            .cast<int>(),
        int.parse(json["path_distance"]),
        int.parse(json["path_elevation"]),
        int.parse(json["path_difficulty"]),
        int.parse(json["time_limit"]),
        int.parse(json["path_points"]),
        json["path_type"],
      );

  Map<String, dynamic> toJson() => {
        "path_id": path_id.toString(),
        "path_name": path_name,
        "path_checkpoint_list": path_checkpoint_list.toString(),
        "path_distance": path_distance.toString(),
        "path_elevation": path_elevation.toString(),
        "path_difficulty": path_difficulty.toString(),
        "time_limit": time_limit.toString(),
        "path_points": path_points.toString(),
        "path_type": path_type,
      };
}
