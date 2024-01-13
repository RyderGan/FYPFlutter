import 'dart:async';
import 'dart:convert';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitnessapp/fitness_app/models/Admin/aboutUsModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:http/http.dart' as http;

class AboutUsUserPage extends StatefulWidget {
  const AboutUsUserPage({Key? key}) : super(key: key);

  @override
  _AboutUsUserPageState createState() => _AboutUsUserPageState();
}

class _AboutUsUserPageState extends State<AboutUsUserPage> {
  AboutUsModel aboutUs =
      AboutUsModel(0, "", "", "", "", "", "", "", "", "", 0, 0);

  Future getAboutUs() async {
    try {
      var res = await http.post(Uri.parse(Api.getAboutUs));
      var resBodyOfLogin = jsonDecode(res.body);
      if (resBodyOfLogin['success']) {
        List<AboutUsModel> aboutUsInfo = await resBodyOfLogin["aboutUs"]
            .map<AboutUsModel>((json) => AboutUsModel.fromJson(json))
            .toList();
        aboutUs = aboutUsInfo[0];
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
        future: Future.wait([getAboutUs()]),
        builder: (context, constraints) {
          return ResponsivePadding(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                title: Text(aboutUs.title),
              ),
              backgroundColor: white,
              body: SafeArea(child: getBody()),
            ),
          );
        });
  }

  Widget getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
          minWidth: double.infinity,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text(
                "Who we are",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              whoWeAre(),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "What is our goal?",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              ourAim(),
              const SizedBox(
                height: 45,
              ),
              const Text(
                "Our related links",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              otherRelatedLinks(),
            ]),
          ),
        ),
      );
    });
  }

  Container whoWeAre() {
    return Container(
      child: Column(
        children: [
          Text(
            aboutUs.who,
            style: TextStylePreset.smallTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            aboutUs.whoDetails,
            style: TextStylePreset.normalText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container ourAim() {
    return Container(
      child: Column(
        children: [
          Text(
            aboutUs.aim,
            style: TextStylePreset.smallTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            aboutUs.aimDetails,
            style: TextStylePreset.normalText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container otherRelatedLinks() {
    return Container(
      child: Column(
        children: [
          const Text(
            "Website",
            style: TextStylePreset.smallTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: aboutUs.websiteName,
                    style: TextStylePreset.linkText,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await goToWebPage(aboutUs.websiteLink);
                      }),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Social Media",
            style: TextStylePreset.smallTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  await goToWebPage(aboutUs.facebookLink);
                },
                icon: const LineIcon.facebook(),
                iconSize: 50,
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () async {
                  await goToWebPage(aboutUs.instagramLink);
                },
                icon: const LineIcon.instagram(),
                iconSize: 50,
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> goToWebPage(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
