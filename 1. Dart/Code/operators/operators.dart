// Get access safety
class User {
  String? name;
}

void main() {
  var a, b;
  dynamic x;
  String? name;
  String? text;

  // Arithmetic
  a = 5;
  b = 2;
  print(a / b); // 2.5
  print(a ~/ b); // 2
  print(a % b); // 1

  // Prefix / postfix increment / decrement
  // Prefix
  a = 5;
  b = ++a;
  print(a); // 6
  print(b); // 6
  // Postfix
  a = 5;
  b = a++;
  print(a); // 6
  print(b); // 5

  // Relational Operators
  print(5 > 3); // true
  print(5 == 5); // true
  print(5 != 2); // true

  // Type test operators
  x = "Hello";
  print(x is String);
  print(x is! String);
  text = x as String;
  print(text.length);

  // Assignment operators
  // Normal
  a = 2;
  a += 5; // a = a + 5
  a -= 2;
  a *= 3;
  a /= 2;
  a ~/= 2;
  a %= 3;
  print(a);

  // Assignment when null
  name ??= "Guest";
  print(name);

  // Logical operators
  a = true;
  b = false;
  print(a && b); // false
  print(b || a); // true
  print(!a); // false

  // Conditional operators
  a = 80;
  String result = a >= 50 ? "Đậu" : "Rớt";
  print(result);

  // Null-coalescing
  String? nickname;
  print(nickname ?? "Guest");

  // Get access safety
  User? user = null;
  print(user?.name ?? "");

  // Null assertion
  text = null;
  // print(text!.length);

  // Cascade
  var buffer = StringBuffer()
    ..write("Hello")
    ..write(" ")
    ..write("World");
  print(buffer.toString());

  // Spread operators
  List<int>? numbers;
  var results = [1, ...?numbers, 5];
  print(results);

  // Bitwise operator
  print(5 & 3); // 1
  print(5 | 3); // 7
  print(5 ^ 3); // 6
}
