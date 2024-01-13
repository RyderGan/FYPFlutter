// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class RewardPointsModel {
  int reward_pt_id;
  int reward_pt;
  int user_id;
  String createdAt;

  RewardPointsModel(
      this.reward_pt_id, this.reward_pt, this.user_id, this.createdAt);

  factory RewardPointsModel.fromJson(Map<String, dynamic> json) =>
      RewardPointsModel(
        int.parse(json["reward_pt_id"]),
        int.parse(json["reward_pt"]),
        int.parse(json["user_id"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "reward_pt_id": reward_pt_id.toString(),
        "reward_pt": reward_pt.toString(),
        "user_id": user_id.toString(),
        "created_at": createdAt,
      };
}
