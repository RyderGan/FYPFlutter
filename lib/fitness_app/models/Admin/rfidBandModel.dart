// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class RfidBandModel {
  int rfid_band_id;
  String uid;
  String name;
  int user_id;
  String createdAt;

  RfidBandModel(
      this.rfid_band_id, this.uid, this.name, this.user_id, this.createdAt);

  factory RfidBandModel.fromJson(Map<String, dynamic> json) => RfidBandModel(
        int.parse(json["rfid_band_id"]),
        json["rfid_band_uid"],
        json["rfid_band_name"],
        int.parse(json["user_id"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "rfid_band_id": rfid_band_id.toString(),
        "rfid_band_uid": uid,
        "rfid_band_name": name,
        "user_id": user_id.toString(),
        "created_at": createdAt,
      };
}
