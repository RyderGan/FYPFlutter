import 'package:fitnessapp/fitness_app/controllers/Admin/adminLoginController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  // Initially password is obscure
  bool _obscureText = true;

  final _adminLoginController = Get.put(adminLoginController());

  // Toggles the password show status
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
          title: const Text("Admin Login Page"),
        ),
        backgroundColor: white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    TextStyle defaultStyle = const TextStyle(color: Colors.black);
    TextStyle linkStyle = const TextStyle(
        color: Colors.blue, decoration: TextDecoration.underline);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _adminLoginController.adminLoginFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            const Text(
                              "Strictly for Administrators Only!!!",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Users are not allowed",
                              style: TextStyle(
                                  fontSize: 10, fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            emailField(),
                            const SizedBox(
                              height: 20,
                            ),
                            passwordField(),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                style: defaultStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Forgot your password?',
                                      style: linkStyle,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(Routes.reset_password);
                                        }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // login button and social login
                      Container(
                          //height: (size.height) * 0.5,
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _adminLoginController.adminLoginProcess();
                            },
                            child: loginButton(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Container loginButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [secondary, primary]),
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
            "Login",
            style: TextStyle(
                fontSize: 16, color: white, fontWeight: FontWeight.bold),
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
                    hintText: 'Password', border: InputBorder.none),
                controller: _adminLoginController.passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                onSaved: (value) {
                  _adminLoginController.password =
                      value!; //! is null check operator
                },
                validator: (value) {
                  return _adminLoginController.validatePassword(value!);
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
                controller: _adminLoginController.emailController,
                onSaved: (value) {
                  _adminLoginController.email =
                      value!; //! is null check operator
                },
                validator: (value) {
                  return _adminLoginController.validateEmail(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
