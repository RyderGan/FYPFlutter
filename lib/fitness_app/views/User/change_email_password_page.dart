import 'package:fitnessapp/fitness_app/controllers/User/changeUserLoginDetailsController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:fitnessapp/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ChangeEmailPasswordPage extends StatefulWidget {
  const ChangeEmailPasswordPage({Key? key}) : super(key: key);

  @override
  _ChangeEmailPasswordPageState createState() =>
      _ChangeEmailPasswordPageState();
}

class _ChangeEmailPasswordPageState extends State<ChangeEmailPasswordPage> {
  final _changeUserLoginDetailsController =
      Get.put(changeUserLoginDetailsController());
  bool _obscureText = true;

  //methods
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          title: const Text("Change Login Credentials"),
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
                "Change email address",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              emailForm(),
              const SizedBox(
                height: 45,
              ),
              const Text(
                "Change password",
                style: TextStylePreset.bigTitle,
              ),
              const SizedBox(
                height: 15,
              ),
              passwordForm(),
            ]),
          ),
        ),
      );
    });
  }

  Form emailForm() {
    return Form(
      key: _changeUserLoginDetailsController.changeUserEmailFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          emailField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _changeUserLoginDetailsController.changeUserEmail();
            },
            child: updateEmailButton(),
          )
        ],
      ),
    );
  }

  Container emailField() {
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
              LineIcons.envelope,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: "Email", border: InputBorder.none),
                keyboardType: TextInputType.emailAddress,
                controller: _changeUserLoginDetailsController.emailController,
                validator: (value) {
                  return _changeUserLoginDetailsController
                      .validateEmail(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container updateEmailButton() {
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
            "Update Email",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }

  Form passwordForm() {
    return Form(
      key: _changeUserLoginDetailsController.changeUserPasswordFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          passwordField(),
          const SizedBox(
            height: 15,
          ),
          confirmPasswordField(),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              _changeUserLoginDetailsController.changeUserPassword();
            },
            child: updatePasswordButton(),
          )
        ],
      ),
    );
  }

  Container passwordField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(
              LineIcons.lock,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: 'New Password', border: InputBorder.none),
                obscureText: _obscureText,
                keyboardType: TextInputType.visiblePassword,
                controller:
                    _changeUserLoginDetailsController.passwordController,
                validator: (value) {
                  return _changeUserLoginDetailsController
                      .validatePassword(value!);
                },
              ),
            ),
            IconButton(
                onPressed: _toggle,
                icon: Icon(
                  LineIcons.eyeAlt,
                  color: black.withOpacity(0.5),
                ))
          ],
        ),
      ),
    );
  }

  Container confirmPasswordField() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgTextField, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Icon(
              LineIcons.lock,
              color: black.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: TextFormField(
                cursorColor: black.withOpacity(0.5),
                decoration: const InputDecoration(
                    hintText: 'Confirm New Password', border: InputBorder.none),
                obscureText: _obscureText,
                keyboardType: TextInputType.visiblePassword,
                controller:
                    _changeUserLoginDetailsController.confirmPasswordController,
                validator: (value) {
                  return _changeUserLoginDetailsController
                      .validatePassword(value!);
                },
              ),
            ),
            IconButton(
                onPressed: _toggle,
                icon: Icon(
                  LineIcons.eyeAlt,
                  color: black.withOpacity(0.5),
                ))
          ],
        ),
      ),
    );
  }

  Container updatePasswordButton() {
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
            "Update Password",
            style: TextStylePreset.btnSmallText,
          )
        ],
      ),
    );
  }
}
