void main() {
  // int
  int age = 22;
  print(age);

  // double
  double pi = 3.14159;
  print(pi);

  // number
  num a = 10;
  num b = 3.14;
  print(a);
  print(b);

  // string
  // concat
  String first = "Nguyen";
  String last = "Quang";
  print(first + " " + last);
  // interpolation
  String name = "Alice";
  print("Tên: $name");
  // list
  var numbers = [1, 2, 3];
  print(numbers[0]); // 1
  for (var item in numbers) {
    print(item);
  }
  // set
  Set<int> setNum = {1, 2, 3};
  setNum.add(3);
  setNum.add(4);
  print(setNum);

  // map
  Map<String, int> scores = {"Alice": 90, "Bob": 85};
  print(scores["Alice"]); // 90
}
