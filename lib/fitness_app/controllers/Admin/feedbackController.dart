import 'dart:convert';
import 'package:fitnessapp/fitness_app/models/Admin/feedbackModel.dart';
import 'package:fitnessapp/fitness_app/services/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class feedbackController extends GetxController {
  List<FeedbackModel> feedback = <FeedbackModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getfeedback();
  }

  @override
  void onClose() {
    feedback.clear();
    super.dispose();
  }

  void getfeedback() async {
    try {
      var res = await http.get(
        Uri.parse(Api.getFeedbackList),
      );

      if (res.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(res.body);
        if (resBodyOfLogin['success']) {
          List<FeedbackModel> feedbacks = await resBodyOfLogin["feedbackList"]
              .map<FeedbackModel>((json) => FeedbackModel.fromJson(json))
              .toList();
          feedback.addAll(feedbacks);
        } else {
          List<FeedbackModel> feedbacks = <FeedbackModel>[];
          feedback.addAll(feedbacks);
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
