import "./animal.dart";

// Constructor
class Dog implements Animal {
  @override
  void eat() {
    print("Dog ăn");
  }

  @override
  void sound() {
    print("Gâu gâu");
  }
}
