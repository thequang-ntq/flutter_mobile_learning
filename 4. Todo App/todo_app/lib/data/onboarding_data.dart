import 'package:todo_app/models/onboarding_slide_model.dart';

class OnboardingData {
  static const slides = [
    OnboardingSlideModel(
      position: 1,
      imageUrl: "assets/images/onboarding/onboarding-1.png",
      title: "Stay on top of your tasks",
      detail:
          "Organize your daily tasks in one place and never miss what matters. Keep track of everything with a simple and clean workspace.",
    ),
    OnboardingSlideModel(
      position: 2,
      imageUrl: "assets/images/onboarding/onboarding-2.png",
      title: "Tap smart, manage faster",
      detail:
          "Tap the round button to select tasks for completing or deleting. Tap the task itself to quickly edit its content.",
    ),
    OnboardingSlideModel(
      position: 3,
      imageUrl: "assets/images/onboarding/onboarding-3.png",
      title: "Create tasks in seconds",
      detail:
          "Tap the + button to add a new task. Write your plan, confirm it, and keep your to-do list up to date.",
    ),
  ];
}
