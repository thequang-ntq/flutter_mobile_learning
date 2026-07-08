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
      position: json["position"] as int,
      imageUrl: json["imageUrl"] as String,
      title: json["title"] as String,
      detail: json["detail"] as String,
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
