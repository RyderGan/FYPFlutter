// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class RfidCheckpointModel {
  int rfid_checkpoint_id;
  String name;
  String description;
  String location;
  String createdAt;

  RfidCheckpointModel(this.rfid_checkpoint_id, this.name, this.description,
      this.location, this.createdAt);

  factory RfidCheckpointModel.fromJson(Map<String, dynamic> json) =>
      RfidCheckpointModel(
        int.parse(json["rfid_checkpoint_id"]),
        json["rfid_checkpoint_name"],
        json["rfid_checkpoint_description"],
        json["rfid_checkpoint_location"],
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "rfid_checkpoint_id": rfid_checkpoint_id.toString(),
        "rfid_checkpoint_name": name,
        "rfid_checkpoint_description": description,
        "rfid_checkpoint_location": location,
        "created_at": createdAt,
      };
}
