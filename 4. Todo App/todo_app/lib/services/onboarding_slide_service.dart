import 'package:todo_app/data/onboarding_data.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';

class OnboardingSlideService {
  static List<OnboardingSlideModel> getAll() {
    return OnboardingData.slides;
  }
}
