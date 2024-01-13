import 'package:fitnessapp/fitness_app/controllers/admin/viewClaimRewardController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewClaimRewardPage extends StatefulWidget {
  const ViewClaimRewardPage({Key? key}) : super(key: key);

  @override
  _ViewClaimRewardPageState createState() => _ViewClaimRewardPageState();
}

class _ViewClaimRewardPageState extends State<ViewClaimRewardPage> {
  final _viewClaimRewardController = Get.put(viewClaimRewardController());

  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var claim_reward_arguments = arguments[0];
    var user_arguments = arguments[1];
    var reward_arguments = arguments[2];
    _viewClaimRewardController.setUserDetails(
        claim_reward_arguments, user_arguments, reward_arguments);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("View Claim Reward"),
        ),
        backgroundColor: white,
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
              claimRewardDetails(),
              const SizedBox(
                height: 45,
              ),
              if (arguments[0].status == "unclaimed")
                InkWell(
                  onTap: () {
                    _viewClaimRewardController.claimReward();
                  },
                  child: claimRewardButton(),
                ),
              if (arguments[0].status == "unclaimed")
                const SizedBox(
                  height: 15,
                ),
              InkWell(
                onTap: () {
                  _viewClaimRewardController.deleteClaimReward();
                },
                child: deleteClaimRewardButton(),
              )
            ]),
          ),
        ),
      );
    });
  }

  Container claimRewardDetails() {
    return Container(
      child: Column(
        children: [
          Text(
            "Title: " + _viewClaimRewardController.titleController.text,
            style: TextStylePreset.bigTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "User Name: ",
            style: TextStylePreset.smallTitle,
          ),
          Text(
            _viewClaimRewardController.userNameController.text,
            style: TextStylePreset.normalText,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "User Email: ",
            style: TextStylePreset.smallTitle,
          ),
          Text(
            _viewClaimRewardController.userEmailController.text,
            style: TextStylePreset.normalText,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Description: ",
            style: TextStylePreset.smallTitle,
          ),
          Text(
            _viewClaimRewardController.descriptionController.text,
            style: TextStylePreset.normalText,
          ),
        ],
      ),
    );
  }

  Container claimRewardButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.green, thirdColor]),
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
            "Claim Reward",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container deleteClaimRewardButton() {
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
            "Delete Claim Reward",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
