import 'package:fitnessapp/fitness_app/models/bloodPressures.dart';
import 'package:fitnessapp/fitness_app/models/bmis.dart';
import 'package:fitnessapp/fitness_app/models/rankings.dart';
import 'package:http/http.dart' as http;
import 'package:fitnessapp/fitness_app/models/stepCounts.dart';
import 'package:fitnessapp/fitness_app/models/visceralFats.dart';

// Use localhost:3000 for iOS and 10.0.2.2:3000 for Android

class RemoteService {
  Future<List<Rankings>?> getStudentRankings() async {
    var client = http.Client();
    print("Connecting 1");
    var uri = Uri.parse('http://10.0.2.2:3000/rankings/student');
    print("Connecting 2");
    var response = await client.get(uri);
    print("Connecting 3");
    if (response.statusCode == 200) {
      print(response.body);
      var json = response.body;
      return rankingsFromJson(json);
    } else {
      print("Error response");
      print(response.statusCode);
    }
  }

  Future<List<Rankings>?> getStaffRankings() async {
    var client = http.Client();

    var uri = Uri.parse('http://10.0.2.2:3000/rankings/staff');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return rankingsFromJson(json);
    }
  }

  Future<StepCounts?> getStepCount() async {
    var client = http.Client();

    var uri = Uri.parse('http://10.0.2.2:3000/stepCounts/6');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      var json = response.body;
      return stepCountsFromJson(json);
    }
  }

  Future<Bmis?> getBmi() async {
    var client = http.Client();

    var uri = Uri.parse('http://10.0.2.2:3000/bmis/6');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      var json = response.body;
      return bmisFromJson(json);
    }
  }

  Future<BloodPressures?> getBloodPressure() async {
    var client = http.Client();

    var uri = Uri.parse('http://10.0.2.2:3000/bloodPressures/6');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      var json = response.body;
      return bloodPressuresFromJson(json);
    }
  }

  Future<VisceralFats?> getVisceralFat() async {
    var client = http.Client();

    var uri = Uri.parse('http://10.0.2.2:3000/visceralFats/6');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      var json = response.body;
      return visceralFatsFromJson(json);
    }
  }
}
