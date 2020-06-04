String scream(int length) => "A${'a' * length}h!";

void main() {
  final values = [0, 1, 3, 10];
  
  // Imperative scream:
  for (var len in values) {
    print(scream(len));
  }
  print('');
  
  // Functional scream:
  values.map(scream).forEach(print);
  print('');

  
  // The classes List and Iterable support:
  // fold(), where(), join(), skip(), and more

  // Skip first value in list, take the next two, apply function, print all
  values.skip(1).take(2).map(scream).forEach(print);
}
