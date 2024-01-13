// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class SetModel {
  int id;
  String name;
  String path_list;
  int bonus_points;

  SetModel(
    this.id,
    this.name,
    this.path_list,
    this.bonus_points,
  );

  factory SetModel.fromJson(Map<String, dynamic> json) => SetModel(
        int.parse(json["set_id"]),
        json["set_name"],
        json["set_path_list"],
        int.parse(json["set_bonus_points"]),
      );

  Map<String, dynamic> toJson() => {
        "set_id": id.toString(),
        "set_name": name,
        "set_path_list": path_list,
        "set_bonus_points": bonus_points.toString(),
      };
}
