void main(List<String> arguments) {
  /// Type inference and type annotation.
  // type annotation refers to declaring a variable with it's type.
  // type inference refers to declaring a variable with a constant or var keyword but it's inferred at runtime.
  final myInteger = 10;
  const myDouble = 3.24;
  num myNumber = 3.14;
  print('Hello world!\n${myDouble.runtimeType}\n${myInteger.runtimeType}');
  print(myNumber.runtimeType);
  print(myNumber is double);
  print(myInteger is double);
  // Type conversion
  var integer = 100;
  var decimal = 12.5;
  integer = decimal.toInt();
  print(integer.toString().runtimeType);
}
