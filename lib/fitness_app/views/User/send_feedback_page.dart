import 'package:fitnessapp/fitness_app/controllers/User/sendFeedbackController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({Key? key}) : super(key: key);

  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final _sendFeedbackController = Get.put(sendFeedbackController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Send feedback"),
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
                "Send Feedback",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              feedbackForm(),
              const SizedBox(
                height: 45,
              ),
              const SizedBox(
                height: 15,
              ),
            ]),
          ),
        ),
      );
    });
  }

  Form feedbackForm() {
    return Form(
      key: _sendFeedbackController.sendFeedbackFormKey,
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
          InkWell(
            onTap: () {
              _sendFeedbackController.sendFeedback();
            },
            child: sendFeedbackButton(),
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
              Icons.title,
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
                keyboardType: TextInputType.text,
                controller: _sendFeedbackController.titleController,
                validator: (value) {
                  return _sendFeedbackController.validateTitle(value!);
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
              Icons.description,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.text,
                controller: _sendFeedbackController.descriptionController,
                validator: (value) {
                  return _sendFeedbackController.validateDescription(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container sendFeedbackButton() {
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
            "Add Feedback",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
