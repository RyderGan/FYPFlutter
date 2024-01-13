// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class PathModel {
  int id;
  String name;
  List<int> checkpoint_list;
  int distance;
  int elevation;
  int difficulty;
  int points;
  int time_limit;

  PathModel(this.id, this.name, this.checkpoint_list, this.distance,
      this.elevation, this.difficulty, this.points, this.time_limit);

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
        int.parse(json["path_points"]),
        int.parse(json["time_limit"]),
      );

  Map<String, dynamic> toJson() => {
        "path_id": id.toString(),
        "path_name": name,
        "path_checkpoint_list":
            checkpoint_list.toString().replaceAll("[", "").replaceAll("]", ""),
        "path_distance": distance.toString(),
        "path_elevation": elevation.toString(),
        "path_difficulty": difficulty.toString(),
        "path_points": points.toString(),
        "time_limit": time_limit.toString(),
      };
}
