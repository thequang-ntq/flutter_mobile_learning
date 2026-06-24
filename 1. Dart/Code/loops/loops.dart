void main() {
  // For
  for (int i = 1; i <= 5; i++) {
    print(i);
  }

  // For in
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  for (var fruit in fruits) {
    print(fruit);
  }

  // For each
  var numbers = [1, 2, 3];
  numbers.forEach((n) {
    print(n);
  });

  // While
  int i = 1;
  while (i <= 3) {
    print(i);
    i++;
  }

  // Do
  i = 10;
  do {
    print(i);
  } while (i < 5);

  // Break
  for (int i = 1; i <= 5; i++) {
    if (i == 3) {
      break;
    }
    print(i);
  }

  // Continue
  for (int i = 1; i <= 5; i++) {
    if (i == 3) {
      continue;
    }

    print(i);
  }

  // Break outer with labels, i = 2, j = 1, then stop the program
  outer:
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        break outer;
      }
      print("$i $j");
    }
  }

  // Continue outer with labels, i = 2, j = 1, then continue to i = 3, j = 1
  outer:
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        continue outer;
      }
      print("$i $j");
    }
  }
}
