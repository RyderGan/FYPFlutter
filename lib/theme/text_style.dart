import 'package:fitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';

class TextStylePreset {
  static const TextStyle btnSmallText = TextStyle(
    fontSize: 18,
    color: white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle btnBigText = TextStyle(
    fontSize: 20,
    color: white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle normalText = TextStyle(
    fontSize: 16,
  );
  static const TextStyle normalWhiteText = TextStyle(
    color: white,
    fontSize: 16,
  );

  static const TextStyle bigText = TextStyle(
    fontSize: 20,
  );
  static const TextStyle bigWhiteText = TextStyle(
    color: white,
    fontSize: 20,
  );
  static const TextStyle bigWhiteBoldText = TextStyle(
    color: white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const TextStyle linkText = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  static const TextStyle smallTitle = TextStyle(
    fontSize: 22,
  );

  static const TextStyle bigTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}
