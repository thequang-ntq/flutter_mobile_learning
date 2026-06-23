// Return type
String greet(String name) {
  return "Xin chào $name";
}

// Not have return type
void sayHello() {
  print("Hello");
}

// Can skip data type (not recommended)
greet_2(name) {
  return "Hello $name";
}

// Required parameters
void printInfo(String name, int age) {
  print("$name - $age");
}

// Named parameters
void createUser({String? name, int? age}) {
  print("$name - $age");
}

// Required for named parameter
void login({required String username, required String password}) {
  print(username); // error
}

// Default named parameters
void show({bool bold = false, bool hidden = false}) {
  print("$bold $hidden");
}

// Optional Positional Parameters
String introduce(String name, [String? city]) {
  if (city != null) {
    return "$name đến từ $city";
  }
  return name;
}

// First class Object
int add(int a, int b) => a + b;

// Anonymous function
var numbers = [1, 2, 3];

// Pass function as a parameter
void printElement(int x) {
  print(x);
}

// Function return function (Closure)
Function makeAdder(int addBy) {
  return (int value) => value + addBy;
}

// Lexical scope
bool topLevel = true;

// Function type
void greet_1(String name, {String greeting = 'Hello'}) =>
    print('$greeting $name!');
// Store `greet` in a variable and call it.
void Function(String, {String greeting}) g = greet_1;

// Tear off
/*
list.forEach(print);
instead of:
list.forEach((item) {
  print(item);
});
*/

// Return value
foo() {} // null

// Record
({String name, int age}) getStudent() {
  return (name: "Quang", age: 22);
}

// Generators
// Sync
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}

Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}

// Getter & Setter
class Person {
  String _name = "";

  String get name => _name;

  set name(String value) {
    _name = value.toUpperCase();
  }
}

// main() is the beginning
Future<void> main() async {
  // Anonymous function
  numbers.forEach((item) => print(item));

  // Pass function as a parameter
  var list = [1, 2, 3];
  list.forEach(printElement);

  // Function return function
  var add5 = makeAdder(5);
  print(add5(10)); // 15

  // Lexical scope
  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }

    nestedFunction();
  }

  myFunction();

  // Function type
  g('Dash', greeting: 'Howdy');

  // Record
  var student = getStudent();
  print(student.name);
  print(student.age);

  // Generators
  for (var x in naturalsTo(5)) {
    print(x);
  }
  await for (var x in asynchronousNaturalsTo(5)) {
    print(x);
  }

  // Getter & Setter
  var p = Person();
  p.name = "quang"; // Assign a value call setter
  print(p.name); // Reading it call a getter
}
