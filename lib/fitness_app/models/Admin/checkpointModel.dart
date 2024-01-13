// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class CheckpointModel {
  int id;
  String name;
  String description;
  String location;
  String type;

  CheckpointModel(
      this.id, this.name, this.description, this.location, this.type);

  factory CheckpointModel.fromJson(Map<String, dynamic> json) =>
      CheckpointModel(
        int.parse(json["checkpoint_id"]),
        json["checkpoint_name"],
        json["checkpoint_description"],
        json["checkpoint_location"],
        json["checkpoint_type"],
      );

  Map<String, dynamic> toJson() => {
        "checkpoint_id": id,
        "checkpoint_name": name,
        "checkpoint_description": description,
        "checkpoint_location": location,
        "checkpoint_type": type,
      };
}
