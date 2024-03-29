import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
                "Who we are",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              whoWeAre(),
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
      child: const Column(
        children: [
          Text(
            "FSKTM students",
            style: TextStylePreset.smallTitle,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "A team of 2 students who developed this app.\n",
            style: TextStylePreset.normalText,
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
                    text: 'IoT FSKTM website',
                    style: TextStylePreset.linkText,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        await goToWebPage("https://www.facebook.com");
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
                  await goToWebPage("https://www.facebook.com");
                },
                icon: const LineIcon.facebook(),
                iconSize: 50,
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () async {
                  await goToWebPage("https://www.facebook.com");
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
