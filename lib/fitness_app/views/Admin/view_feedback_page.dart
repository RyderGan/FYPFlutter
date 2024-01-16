import 'package:fitnessapp/fitness_app/controllers/admin/viewFeedbackController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewFeedbackPage extends StatefulWidget {
  const ViewFeedbackPage({Key? key}) : super(key: key);

  @override
  _ViewFeedbackPageState createState() => _ViewFeedbackPageState();
}

class _ViewFeedbackPageState extends State<ViewFeedbackPage> {
  final _viewFeedbackController = Get.put(viewFeedbackController());

  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    _viewFeedbackController.setUserDetails(arguments);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text("View feedback"),
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
              feedbackDetails(),
              const SizedBox(
                height: 45,
              ),
              InkWell(
                onTap: () {
                  _viewFeedbackController.deleteFeedback();
                },
                child: deleteFeedbackButton(),
              )
            ]),
          ),
        ),
      );
    });
  }

  Container feedbackDetails() {
    return Container(
      child: Column(
        children: [
          Text(
            "Title: " + arguments.title,
            style: TextStylePreset.bigTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Description: ",
            style: TextStylePreset.normalText,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            arguments.description,
            style: TextStylePreset.smallTitle,
          ),
        ],
      ),
    );
  }

  Container deleteFeedbackButton() {
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
            Icons.delete,
            color: white,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Delete Feedback",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
