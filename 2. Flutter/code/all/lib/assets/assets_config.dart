class AssetsConfig {
  // Image assets
  static const String image1 = 'assets/images/img-1.jpg';
  static const String image2 = 'assets/images/img-2.jpg';
  static const String image3 = 'assets/images/img-3.jpg';
  static const String image4 = 'assets/images/img-4.jpg';
  static const String image5 = 'assets/images/img-5.jpg';

  // JSON assets
  static const String jsonFile = 'assets/json/64KB.json';

  // Grid config
  static const int gridCrossAxisCount = 2;

  // Helper method
  static String getGridImage(int index) {
    final imageNumber = (index % 5) + 1;
    return 'assets/images/img-$imageNumber.jpg';
  }
}
