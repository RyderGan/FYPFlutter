// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class ClaimRewardModel {
  int id;
  int reward_id;
  int user_id;
  String status;
  String createdAt;

  ClaimRewardModel(
      this.id, this.reward_id, this.user_id, this.status, this.createdAt);

  factory ClaimRewardModel.fromJson(Map<String, dynamic> json) =>
      ClaimRewardModel(
        int.parse(json["claim_reward_id"]),
        int.parse(json["reward_id"]),
        int.parse(json["user_id"]),
        json["claim_reward_status"],
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "claim_reward_id": id.toString(),
        "user_id": user_id.toString(),
        "reward_id": reward_id.toString(),
        "claim_reward_status": status,
        "created_at": createdAt,
      };
}
