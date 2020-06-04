import '1_bicycles.dart';


void bicycles_codelab() {
  // https://itnext.io/difference-between-const-and-final-in-dart-78c129d0c573
  
  // const vars are assigned at compile-time.
  // final vars are assigned at run-time.
  
  // in Flutter, final vars are used since widgets get rebuilt - 
  // effectively ensuring 1 assignment per instance over multiple instances.

  // Use var if need multiple reassignment at run-time.
  const cadence = 13;
  final bike = Bicycle(1, 2);
  var bike_2 = Bicycle(2, 0);
  // Bicycle bike_2 = Bicycle(2, 1, 0);  // And don't do this for local vars.
  
  bike.cadence = 12;
  bike_2.cadence = 42;
  // cadence = 14;  // illegal for const variables

  // bike = Bicycle(1, 0, 2);  // illegal for final variables
  bike_2 = Bicycle(42, 11);

  print('bike has cadence: ' + bike.cadence.toString());
  print('bike_2 has cadence: ' + bike_2.cadence.toString());
  print('cadence is: ' + cadence.toString());

  // May only access read-only inst var speed via getter
  // May only update read-only inst var speed via internal methods or setters
  // print(bike_2._speed);
  print(bike_2.speed);
  bike_2.speedUp(10);
  bike_2.applyBrake(3);
  print(bike_2.speed);
}


void some_codelab() {}


void main(List<String> arguments) { 
  // This is defined as project's main.
  // It contains additional musings/thoughts not in exercises.
  bicycles_codelab();
}
