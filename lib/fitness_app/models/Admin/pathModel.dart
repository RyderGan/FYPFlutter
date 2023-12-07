// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class PathModel {
  int path_id;
  String name;
  String fromCpID;
  String toCpID;
  int distance;
  int elevation;
  int difficulty;

  PathModel(
    this.path_id,
    this.name,
    this.fromCpID,
    this.toCpID,
    this.distance,
    this.elevation,
    this.difficulty,
  );

  factory PathModel.fromJson(Map<String, dynamic> json) => PathModel(
        int.parse(json["path_id"]),
        json["path_name"],
        json["path_from_cp_id"],
        json["path_to_cp_id"],
        int.parse(json["path_distance"]),
        int.parse(json["path_elevation"]),
        int.parse(json["path_difficulty"]),
      );

  Map<String, dynamic> toJson() => {
        "path_id": path_id.toString(),
        "path_name": name,
        "path_from_cp_id": fromCpID,
        "path_to_cp_id": toCpID,
        "path_distance": distance.toString(),
        "path_elevation": elevation.toString(),
        "path_difficulty": difficulty.toString(),
      };
}
