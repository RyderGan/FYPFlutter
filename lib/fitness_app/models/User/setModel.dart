// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);
import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/User/pathModel.dart';

class SetModel {
  int set_id;
  String set_name;
  List<int> paths;
  int set_bonusPoints;

  SetModel(this.set_id, this.set_name, this.paths, this.set_bonusPoints);

  factory SetModel.fromJson(Map<String, dynamic> json) => SetModel(
      int.parse(json["set_id"]),
      json["set_name"],
      json["set_path_list"].split(",").map(int.parse).toList().cast<int>(),
      int.parse(json["set_bonus_points"]));

  Map<String, dynamic> toJson() => {
        "set_id": set_id.toString(),
        "set_name": set_name,
        "set_path_list": paths.toString(),
        //paths.map((el) => el.toString()).toList().join(",")
        "set_bonus_points": set_bonusPoints.toString()
      };
}
