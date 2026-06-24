void main() {
  // If
  int age = 20;
  if (age >= 18) {
    print("Đủ tuổi");
  }

  // If-else
  int score = 40;
  if (score >= 50) {
    print("Đậu");
  } else {
    print("Rớt");
  }

  // If ... else if ... else (multiple else if, 1 if, 1 else)
  score = 85;
  if (score >= 90) {
    print("A");
  } else if (score >= 80) {
    print("B");
  } else if (score >= 70) {
    print("C");
  } else {
    print("F");
  }

  // If-case
  var pair = [10, 20];
  if (pair case [int x, int y]) {
    print("x = $x");
    print("y = $y");
  }

  // Switch statements
  String command = "OPEN";
  switch (command) {
    case 'OPEN':
      print(1);
      continue newCase; // Continues executing at the newCase label.

    case 'DENIED': // Empty case falls through.
    case 'CLOSED':
      print(1); // Runs for both DENIED and CLOSED,

    newCase:
    case 'PENDING':
      print(1); // Runs for both OPEN and PENDING.
  }

  // Switch expression
  int? charCode;
  String? token = switch (charCode) {
    null || -1 => "",
    0 || 1 => "Bit",
    >= 0 && <= 9 => "Hello",
    _ => throw FormatException('Invalid'), // Wildcard
  };
  print(token);
}
