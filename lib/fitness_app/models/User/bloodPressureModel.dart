// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class BloodPressureModel {
  int bpID;
  int userID;
  int systolic;
  int diastolic;
  String createdAt;

  BloodPressureModel(
      this.bpID, this.userID, this.systolic, this.diastolic, this.createdAt);

  factory BloodPressureModel.fromJson(Map<String, dynamic> json) =>
      BloodPressureModel(
        int.parse(json["bp_id"]),
        int.parse(json["user_id"]),
        int.parse(json["systolic_pressure"]),
        int.parse(json["diastolic_pressure"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "bp_id": bpID.toString(),
        "user_id": userID.toString(),
        "systolic_pressure": systolic.toString(),
        "diastolic_pressure": diastolic.toString(),
        "created_at": createdAt,
      };
}
