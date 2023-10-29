// @dart=2.12.0

import 'package:fitnessapp/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fitnessapp/fitness_app/views/User/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/routes.dart';

final String supabaseUrl = 'https://hmgphwmcjhygwlxtcqjs.supabase.co';
final String supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhtZ3Bod21jamh5Z3dseHRjcWpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg1NzkxMDEsImV4cCI6MjAxNDE1NTEwMX0.hN_Ij7a9i13PVro_-LTezDpAM3pTsftpHaM87uDAVq4';
void main() {
  Get.put<SupabaseClient>(SupabaseClient(supabaseUrl, supabaseKey));
  Get.put<GetStorage>(GetStorage());
  runApp(MyApp());
}

//final supabase = Supabase.instance.client;

GetMaterialApp MyApp() {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.login,
    //home: LoginPage(),
    getPages: getPages,
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
