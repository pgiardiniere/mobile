import 'dart:math';

abstract class Shape {
  // Factory type 2: using 'factory' keyword inside class.
  factory Shape(String type) {
    if (type == 'circle') return Circle(2);
    if (type == 'square') return Square(2);
    throw "Can't create $type";
  }
  num get area;
}

class Circle implements Shape {
  final num radius;
  Circle(this.radius);
  @override
  num get area => pi * pow(radius, 2);
}

class Square implements Shape {
  final num side;
  Square(this.side);
  @override
  num get area => pow(side, 2);
}

// Factory type 1: top-level function
Shape shapeFactory(String type) {
  if (type == 'circle') return Circle(2);
  if (type == 'square') return Square(2);
  throw "Can't create $type";
}

void main(List<String> args) {
  // Non-factory construction of objects.
  final circle = Circle(2);
  final square = Square(2);
  print(circle.area);
  print(square.area);

  // Now use factory type one: top-level function
  final circle_2 = shapeFactory('circle');
  final square_2 = shapeFactory('square');
  print(circle_2.area);
  print(square_2.area);

  // Now use factory type two: Factory constructor.
  final circle_3 = Shape('circle');
  final square_3 = Shape('square');
  print(circle_3.area);
  print(square_3.area);

  // Test CircleMock.
  final mock_circ = CircleMock();
  print(mock_circ.area);
}

// Interface note: dart has no keyword 'interface' as every class defines one.
// E.g. the following line throws a 'missing concrete implementations' error, as
// CircleMock doesn't inherit the implementation of Circle; only its interface:

// class CircleMock implements Circle {}

class CircleMock implements Circle {
  @override
  num area;
  @override
  num radius;
}
