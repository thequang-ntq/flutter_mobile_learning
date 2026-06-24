// Members
// Constructor with variables
// Getter / setter
class Student {
  String _name = ""; // field

  set name(String name) {
    _name = name.trim();
  }

  String get name => _name;
}
