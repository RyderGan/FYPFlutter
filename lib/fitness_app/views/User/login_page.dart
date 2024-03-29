import 'package:fitnessapp/fitness_app/controllers/User/loginController.dart';
import 'package:fitnessapp/fitness_app/views/responsive_padding.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = Get.put(loginController());
  // Initially password is obscure
  bool _obscureText = true;
  String dropDownValue = 'Select user';

  var users = [
    'Select user',
    'Staff',
    'Student',
  ];

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: getBody()),
      ),
    );
  }

  Widget getBody() {
    TextStyle defaultStyle = const TextStyle(color: Colors.black);
    TextStyle linkStyle = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
      fontSize: 15,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _loginController.loginFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            const Text(
                              "Hey there,",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Welcome Back",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                            userTypeField(),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      // login button and social login
                      Container(
                          //height: (size.height) * 0.5,
                          child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _loginController.loginProcess();
                            },
                            child: loginButton(),
                          ),
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
                          const Row(
                            children: [
                              Flexible(
                                child: Divider(
                                  thickness: 0.8,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Or"),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Divider(
                                  thickness: 0.8,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              style: defaultStyle,
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "Don't have account yet? ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                    text: 'Register now',
                                    style: linkStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.register);
                                      }),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              style: defaultStyle,
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "Others: ",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                    text: 'Admin Only',
                                    style: linkStyle,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.admin_login);
                                      }),
                              ],
                            ),
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

  Container userTypeField() {
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
        value: dropDownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: users.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropDownValue = newValue!;
            _loginController.userType.value = dropDownValue;
          });
        },
        validator: (userTypeValue) {
          if (userTypeValue == "Select user") {
            return "Please select a user";
          }
          return null;
        },
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
                controller: _loginController.passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                onSaved: (value) {
                  _loginController.password = value!; //! is null check operator
                },
                validator: (value) {
                  return _loginController.validatePassword(value!);
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
                controller: _loginController.emailController,
                onSaved: (value) {
                  _loginController.email = value!; //! is null check operator
                },
                validator: (value) {
                  return _loginController.validateEmail(value!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
