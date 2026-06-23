void main() {
  // var
  var x = 10;
  // has type
  String y = "a";
  // object
  Object value = "Hello";
  value = 100;
  // dynamic
  dynamic data = "Hello";
  data = 123;
  // data.noSuchMethod();
  // null safety / nullable
  String? name;
  // late
  late String description = "Late initialized";
  // final
  final currentTime = DateTime.now();
  // const
  const pi = 3.14;
  // wildcard variables
  for (var (_, value) in [(1, 'A'), (2, 'B'), (3, 'C')]) {
    print(value); // A	B	C
  }

  print(x);
  print(y);
  print(value);
  print(data);
  print(name);
  print(description);
  print(currentTime);
  print(pi);
}
