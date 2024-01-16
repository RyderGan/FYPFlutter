import 'dart:async';
import 'dart:convert';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
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
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class AboutUsAdminPage extends StatefulWidget {
  const AboutUsAdminPage({Key? key}) : super(key: key);

  @override
  _AboutUsAdminPageState createState() => _AboutUsAdminPageState();
}

class _AboutUsAdminPageState extends State<AboutUsAdminPage> {
  AboutUsModel aboutUs = Get.arguments;
  LatLng coordinates = LatLng(Get.arguments.lat, Get.arguments.long);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text("About Us"),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(child: getBody()),
      ),
    );
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
                "Faculty:",
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
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: FlutterMap(
                  options: MapOptions(
                    center: coordinates,
                    zoom: 16,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: coordinates,
                          alignment: Alignment.topLeft,
                          width: 25,
                          height: 25,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.edit_about_us_info, arguments: aboutUs);
                },
                child: editAboutUsButton(),
              )
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
              const SizedBox(
                height: 15,
              )
            ],
          )
        ],
      ),
    );
  }

  Container editAboutUsButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.red, thirdColor]),
          borderRadius: BorderRadius.circular(30)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.arrow_forward_sharp,
            color: white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Edit About Us",
            style: TextStylePreset.btnSmallText,
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
