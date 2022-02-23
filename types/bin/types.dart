void main(List<String> arguments) {
  /// Type inference and type annotation.
  // type annotation refers to declaring a variable with it's type.
  // type inference refers to declaring a variable with a constant or var keyword but it's inferred at runtime.
  int myInteger = 10;
  double myDouble = 3.24;
  print('Hello world!\n${myDouble.runtimeType}\n${myInteger.runtimeType}');
}
