// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class AboutUsModel {
  int about_us_id;
  String title;
  String who;
  String whoDetails;
  String aim;
  String aimDetails;
  String websiteName;
  String websiteLink;
  String facebookLink;
  String instagramLink;
  double lat;
  double long;

  AboutUsModel(
      this.about_us_id,
      this.title,
      this.who,
      this.whoDetails,
      this.aim,
      this.aimDetails,
      this.websiteName,
      this.websiteLink,
      this.facebookLink,
      this.instagramLink,
      this.lat,
      this.long);

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
      int.parse(json["about_us_id"]),
      json["about_us_title"],
      json["about_us_who"],
      json["about_us_who_details"],
      json["about_us_aim"],
      json["about_us_aim_details"],
      json["about_us_website_name"],
      json["about_us_website_link"],
      json["about_us_facebook_link"],
      json["about_us_instagram_link"],
      double.parse(json["about_us_lat"]),
      double.parse(json["about_us_long"]));

  Map<String, dynamic> toJson() => {
        "about_us_id": about_us_id.toString(),
        "about_us_title": title,
        "about_us_who": who,
        "about_us_who_details": whoDetails,
        "about_us_aim": aim,
        "about_us_aim_details": aimDetails,
        "about_us_website_name": websiteName,
        "about_us_website_link": websiteLink,
        "about_us_facebook_link": facebookLink,
        "about_us_instagram_link": instagramLink,
        "about_us_lat": lat.toString(),
        "about_us_long": long.toString(),
      };
}
