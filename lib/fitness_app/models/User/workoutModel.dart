// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class WorkoutModel {
  int workout_id;
  int workout_set_id;
  String workout_path_list;
  String workout_checkpoint_list;
  String workout_passed_list;
  int workout_user_id;
  String workout_status;

  WorkoutModel(
      this.workout_id,
      this.workout_set_id,
      this.workout_path_list,
      this.workout_checkpoint_list,
      this.workout_passed_list,
      this.workout_user_id,
      this.workout_status);

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
        int.parse(json["workout_id"]),
        int.parse(json["workout_set_id"]),
        json["workout_path_list"],
        json["workout_checkpoint_list"],
        json["workout_passed_list"],
        int.parse(json["workout_user_id"]),
        json["workout_status"],
      );

  Map<String, dynamic> toJson() => {
        "workout_id": workout_id.toString(),
        "workout_set_id": workout_set_id.toString(),
        "workout_path_list": workout_path_list,
        "workout_checkpoint_list": workout_checkpoint_list,
        "workout_passed_list": workout_passed_list,
        "workout_user_id": workout_user_id.toString(),
        "workout_status": workout_status,
      };
}
