import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String auth_token = "auth_token";
  late final SharedPreferences prefs;

//set data into shared preferences like this
  Future<void> setAuthToken(String auth_token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, auth_token);
  }

//get value from shared preferences
  Future<String?> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? auth_token;
    auth_token = (pref.getString(this.auth_token) ?? null);
    return auth_token;
  }

  clearAll() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

//Call sessionManager inside a class
//SessionManager prefs = SessionManager();

//set userID when login
//prefs.setAuthToken(data['data']['UserID']);

//prefs.getAuthToken();// it returns future 

//getting userID
// prefs.getAuthToken().then((value) {
//   print(value); //this is your used id
// }