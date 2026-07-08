import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';
import 'package:todo_app/utils/constants.dart';

class OnboardingSlideService {
  static Future<List<OnboardingSlideModel>> getAll() async {
    final jsonString = await rootBundle.loadString(
      "${Constants.baseJsonUrl}/onboarding_slides.json",
    );
    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.map((e) {
      return OnboardingSlideModel.fromJson(e);
    }).toList();
  }
}
