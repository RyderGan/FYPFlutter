// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class RewardModel {
  int id;
  String title;
  String description;
  int required_pt;
  String createdAt;

  RewardModel(
      this.id, this.title, this.description, this.required_pt, this.createdAt);

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
        int.parse(json["reward_id"]),
        json["reward_title"],
        json["reward_description"],
        int.parse(json["required_pt"]),
        json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "reward_id": id.toString(),
        "reward_title": title,
        "reward_description": description,
        "required_pt": required_pt.toString(),
        "created_at": createdAt,
      };
}
