class OnboardingSlideModel {
  final int position;
  final String imageUrl;
  final String title;
  final String detail;

  const OnboardingSlideModel({
    required this.position,
    required this.imageUrl,
    required this.title,
    required this.detail,
  });

  factory OnboardingSlideModel.fromJson(Map<String, dynamic> json) {
    return OnboardingSlideModel(
      position: json["position"],
      imageUrl: json["imageUrl"],
      title: json["title"],
      detail: json["detail"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "position": position,
      "imageUrl": imageUrl,
      "title": title,
      "detail": detail,
    };
  }
}
