import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/onboarding_data.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';

class OnboardingSlideService {
  static const String _keyHasSeenOnboarding = 'hasSeenOnboarding';

  static List<OnboardingSlideModel> getAll() {
    return OnboardingData.slides;
  }

  static Future<bool> hasSeenOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_keyHasSeenOnboarding) ?? false;
    } catch (e) {
      throw Exception("Failed to get data from preferences");
    }
  }

  static Future<void> setHasSeenOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyHasSeenOnboarding, true);
    } catch (e) {
      throw Exception("Failed to set data to preferences");
    }
  }
}
