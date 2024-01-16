import 'package:fitnessapp/fitness_app/controllers/Admin/editCheckpointInfoController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCheckpointInfoPage extends StatefulWidget {
  const EditCheckpointInfoPage({Key? key}) : super(key: key);

  @override
  _EditCheckpointInfoPageState createState() => _EditCheckpointInfoPageState();
}

class _EditCheckpointInfoPageState extends State<EditCheckpointInfoPage> {
  final _editCheckpointInfoController = Get.put(EditCheckpointInfoController());
  var arguments = Get.arguments;
  var types = [
    'Select type',
    'RFID',
    'QR Code',
  ];

  //methods

  @override
  Widget build(BuildContext context) {
    _editCheckpointInfoController.setCheckpointDetails(arguments);
    // TODO: implement build
    return ResponsivePadding(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          title: const Text("Edit Checkpoint Information"),
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
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text(
                "Edit Checkpoint info",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              checkpointInfoForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form checkpointInfoForm() {
    return Form(
      key: _editCheckpointInfoController.editCheckpointInfoFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          nameField(),
          const SizedBox(
            height: 15,
          ),
          descriptionField(),
          const SizedBox(
            height: 15,
          ),
          locationField(),
          const SizedBox(
            height: 15,
          ),
          typeField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editCheckpointInfoController.updateCheckpointInfo(arguments);
            },
            child: updateCheckpointInfoButton(),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _editCheckpointInfoController.deleteCheckpoint(arguments);
            },
            child: deleteCheckpointButton(),
          )
        ],
      ),
    );
  }

  Container nameField() {
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
                    hintText: "Name", border: InputBorder.none),
                keyboardType: TextInputType.name,
                controller: _editCheckpointInfoController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name";
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
                keyboardType: TextInputType.text,
                controller: _editCheckpointInfoController.descriptionController,
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

  Container locationField() {
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
                    hintText: "Location", border: InputBorder.none),
                keyboardType: TextInputType.text,
                controller: _editCheckpointInfoController.locationController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter location";
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

  Container typeField() {
    String typeValue = arguments.type;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: black.withOpacity(0.1)),
      ),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        value: typeValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: types.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            typeValue = newValue!;
            arguments.type = typeValue;
          });
        },
        validator: (checkpointTypeValue) {
          if (checkpointTypeValue == "Select type") {
            return "Please select a type";
          }
          return null;
        },
      ),
    );
  }

  Container updateCheckpointInfoButton() {
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
            "Update Checkpoint Info",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Container deleteCheckpointButton() {
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
            "Delete Checkpoint",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
