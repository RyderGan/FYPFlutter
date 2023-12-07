import 'package:fitnessapp/fitness_app/controllers/Admin/editRewardInfoController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRewardInfoPage extends StatefulWidget {
  const EditRewardInfoPage({Key? key}) : super(key: key);

  @override
  _EditRewardInfoPageState createState() => _EditRewardInfoPageState();
}

class _EditRewardInfoPageState extends State<EditRewardInfoPage> {
  final _editRewardInfoController = Get.put(editRewardInfoController());
  var arguments = Get.arguments;

  //methods

  @override
  Widget build(BuildContext context) {
    _editRewardInfoController.setRewardDetails(arguments);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Edit Reward Information"),
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
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text(
                "Edit Reward info",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              rewardInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form rewardInfoForm() {
    return Form(
      key: _editRewardInfoController.editRewardInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          titleField(),
          const SizedBox(
            height: 15,
          ),
          descriptionField(),
          const SizedBox(
            height: 15,
          ),
          pointField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editRewardInfoController.updateRewardInfo(arguments);
            },
            child: updateRewardInfoButton(),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editRewardInfoController.deleteReward(arguments);
            },
            child: deleteRewardButton(),
          )
        ],
      ),
    );
  }

  Container titleField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Title", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editRewardInfoController.titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container descriptionField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Description", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editRewardInfoController.descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container pointField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Icon(
              Icons.abc,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Points", border: InputBorder.none),
                keyboardType: TextInputType.number,
                controller: _editRewardInfoController.pointController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter points";
                  } else if (!value.isNum) {
                    return "Please input a number";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container updateRewardInfoButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [fourthColor, thirdColor]),
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
            "Update Reward Info",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container deleteRewardButton() {
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
            "Delete Reward",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
