// Non nullable & nullable
void bad(String? maybeString) {
  // print(maybeString.length);
  print(maybeString.hashCode);
}

// Required
void show({String? name}) {}
void show_re({required String name}) {}

// Value to test logic adbecmeD
String? name;

// Type ??
class User {
  String? name;
}

void main() {
  bad(null);

  // Type ?
  User? user = null;
  print(user?.name);
  String? name = "Quang";
  print(name.length);

  //  Type ??
  name = null;
  print(name ?? "Unknown");

  // Type !
  name = "Quang";
  print(name.length);
  // print(name!.length);

  // Initialize variable
  String a = "";
  print(a);

  // Late (LateInitializationError)
  late String l_b;
  l_b = "";
  print(l_b);

  // Required
  show();
  show_re(name: "name");
}
