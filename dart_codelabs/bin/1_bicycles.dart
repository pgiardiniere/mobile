class Bicycle {
  // By default, instance variables are public.
  // By prepend '_', instance variables are private (i.e. read-only)
  int cadence;
  int _speed = 0;
  int gear;

  Bicycle(this.cadence, this.gear);

  int get speed => _speed;
  set speed(val) => _speed = val;

  void applyBrake(int decrement) {
    _speed -= decrement;
  }

  void speedUp(int increment) {
    _speed += increment;
  }

  @override
  String toString() => 'Bicycle: $_speed mph';
}

void main() {
  var bike = Bicycle(2, 1);
  print(bike.toString());

  bike._speed = 12;
  print(bike.toString());
}
