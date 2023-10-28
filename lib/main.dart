// @dart=2.12.0

import 'package:fitnessapp/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fitnessapp/fitness_app/views/User/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/routes.dart';

final String supabaseUrl = 'https://rghbecweyfhlrjureyxr.supabase.co';
final String supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJnaGJlY3dleWZobHJqdXJleXhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc5NjA5MjgsImV4cCI6MjAxMzUzNjkyOH0.BMgHW2hOiUDmJVdkuJ6wRHST04vgEdDHBWd1kJr-O0w';
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
