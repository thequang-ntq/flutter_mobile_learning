import 'dart:isolate';

Future<void> main() async {
  // Async / await
  // No await -> A C (2 seconds) B
  // Await -> A (2 seconds) B C
  print("A");
  await Future.delayed(Duration(seconds: 2), () {
    print("B");
  });
  print("C");

  // Stream
  Stream<int> numbers() async* {
    yield 1;
    yield 2;
    yield 3;
  }

  await for (final n in numbers()) {
    print(n);
  }

  // Return i^2 every one second, break when i > 100
  Stream<int> stream = Stream.periodic(
    const Duration(seconds: 1),
    (i) => i * i,
  );
  await for (final i in stream) {
    print(i);
    if (i > 1) break;
  }

  // Isolate.run()
  Future<void> calculate() async {
    final result = await Isolate.run(() {
      return 1000000 * 1000000;
    });

    print(result);
  }

  calculate();
}
