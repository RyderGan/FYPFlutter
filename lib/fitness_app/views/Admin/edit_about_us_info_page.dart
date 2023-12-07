import 'package:fitnessapp/fitness_app/controllers/Admin/editAboutUsInfoController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAboutUsInfoPage extends StatefulWidget {
  const EditAboutUsInfoPage({Key? key}) : super(key: key);

  @override
  _EditAboutUsInfoPageState createState() => _EditAboutUsInfoPageState();
}

class _EditAboutUsInfoPageState extends State<EditAboutUsInfoPage> {
  final _editAboutUsInfoController = Get.put(EditAboutUsInfoController());
  var arguments = Get.arguments;

  //methods

  @override
  Widget build(BuildContext context) {
    _editAboutUsInfoController.setAboutUsDetails(arguments);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text("Edit About Us Information"),
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
                "Edit About Us info",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              aboutUsInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form aboutUsInfoForm() {
    return Form(
      key: _editAboutUsInfoController.editAboutUsInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          titleField(),
          const SizedBox(
            height: 15,
          ),
          whoField(),
          const SizedBox(
            height: 15,
          ),
          whoDetailsField(),
          const SizedBox(
            height: 15,
          ),
          aimField(),
          const SizedBox(
            height: 15,
          ),
          aimDetailsField(),
          const SizedBox(
            height: 15,
          ),
          websiteNameField(),
          const SizedBox(
            height: 15,
          ),
          websiteLinkField(),
          const SizedBox(
            height: 15,
          ),
          facebookLinkField(),
          const SizedBox(
            height: 15,
          ),
          instagramLinkField(),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              _editAboutUsInfoController.updateAboutUsInfo(arguments);
            },
            child: updateAboutUsInfoButton(),
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
                controller: _editAboutUsInfoController.titleController,
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

  Container whoField() {
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
                    hintText: "Who", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editAboutUsInfoController.whoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter who we are details";
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

  Container whoDetailsField() {
    return Container(
      height: 100,
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
                    hintText: "Who Details", border: InputBorder.none),
                keyboardType: TextInputType.multiline,
                minLines: 2, // Set this
                maxLines: 10, // and this
                controller: _editAboutUsInfoController.whoDetailsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter who we are details";
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

  Container aimField() {
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
                    hintText: "Aim", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editAboutUsInfoController.aimController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter aim";
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

  Container aimDetailsField() {
    return Container(
      height: 100,
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
                    hintText: "Aim Details", border: InputBorder.none),
                keyboardType: TextInputType.multiline,
                minLines: 2, // Set this
                maxLines: 10, // and this
                controller: _editAboutUsInfoController.aimDetailsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter aim details";
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

  Container websiteNameField() {
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
                    hintText: "Website Name", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editAboutUsInfoController.websiteNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter website name";
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

  Container websiteLinkField() {
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
                    hintText: "Website Link", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editAboutUsInfoController.websiteLinkController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter website link";
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

  Container facebookLinkField() {
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
                    hintText: "Facebook Link", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editAboutUsInfoController.facebookLinkController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter facebook link";
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

  Container instagramLinkField() {
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
                    hintText: "Instragram Link", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editAboutUsInfoController.instagramLinkController,
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

  Container updateAboutUsInfoButton() {
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
            "Update About Us Info",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
