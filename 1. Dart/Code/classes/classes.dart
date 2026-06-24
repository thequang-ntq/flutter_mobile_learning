import "./models/person.dart";
import "./models/student.dart";
import "./models/dog.dart";
import "./models/point.dart";
import "./models/user.dart";
import "./models/rectangle.dart";
import "./utils/MathUtil.dart";
import "models/circle.dart";

void main() {
  // Class, object (instance)
  // var p = Person("Quang");
  // print(p.name);
  // p.sayHello();

  // Members
  // var s = Student();
  // print(s.name);
  // s.introduce();

  // Constructor
  Dog();

  // Constructor with parameter
  // var ps = Person("Quang");
  // print(ps.name);

  // Constructor shortened
  // var p = Person("Quang");
  // print(p.name);
  // var s = Student("Quang", 22);
  // print(s.name);
  // s.introduce();

  // Named constructor
  // var p1 = Point(3, 4);
  // var p2 = Point.origin();
  // print(p1);
  // print(p2);

  // Constructor with named parameter
  // var u = User(name: "Quang", age: 22);
  // print(u);

  // Initialized list
  // () : ... {}

  // Getter / setter
  // var r = Rectangle();
  // print(r.area);
  // var s = Student();
  // s.name = "Quang";
  // print(s.name);

  // Final / const Constructor
  // var user = User("Quang");
  // var p1 = Point(1, 1);
  // var p2 = Point(1, 1);
  // print(user);
  // print(identical(p1, p2)); // true

  // Math / util]print(MathUtil.pi);
  // print(MathUtil.pi);
  // print(MathUtil.add(2, 3));

  // Extends
  // var d = Dog();
  // d.eat();
  // d.bark();

  // Override
  // var d = Dog();
  // d.sound();

  // Implements
  // var d = Dog();
  // d.eat();
  // d.sound();

  // Abstract class
  // var c = Circle();
  // print(c.area());

  // Runtime Type
  var p = Person("Quang");
  print(p.runtimeType);
}
