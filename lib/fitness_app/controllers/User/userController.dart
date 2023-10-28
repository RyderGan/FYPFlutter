import 'package:flutter/material.dart';
import 'package:fitnessapp/fitness_app/models/User/userModel.dart';
import 'package:fitnessapp/fitness_app/views/User/register_page.dart';
import 'package:get/get.dart';

class userController extends GetxController {
  factory userController() => _this ??= userController._();
  userController._();
  static userController? _this;

  /// Initialize any 'time-consuming' operations at the beginning.
  /// Initialize asynchronous items essential to the Mobile Applications.
  /// Typically called within a FutureBuilder() widget.
  @override
  Future<bool> initAsync() async {
    // Simply wait for 10 seconds at startup.
    /// In production, this is where databases are opened, logins attempted, etc.
    return Future.delayed(const Duration(seconds: 10), () {
      return true;
    });
  }

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding initAsync() routine.
  /// Returns true if the error was properly handled.
  @override
  bool onAsyncError(FlutterErrorDetails details) {
    return false;
  }
}
