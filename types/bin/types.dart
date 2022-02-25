import 'package:characters/characters.dart';
void main(List<String> arguments) {
  /*/// Type inference and type annotation.
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
  // Operators with mixed types
  const hourlyRate = 19.5;
  const hoursWorked = 10;
  final totalCost = hourlyRate * hoursWorked;
  print(totalCost.toInt().runtimeType);
  // Ensuring a certain type
  final wantADouble = 3.toDouble();
  print(wantADouble);
  // Casting Down
  num someNumber = 3;
  final someInt = someNumber as int;
  final someDouble =  someNumber.toDouble();
  print(someInt.isEven);
  print(someDouble);*/
 /* // Mini exercise
  const age1 = 42;
  const age2 = 21;
  const averageAge = (age1 + age2) / 2;
  print(averageAge.toInt().isEven.runtimeType); // averageAge is a double because it's dividing and the result will be a floating-point number.*/
  /*/// Strings
  var greeting = 'Hello, dart!';
  print(greeting.toString().toUpperCase().codeUnits.reversed.runtimeType);
  greeting = 'Hello, Flutter!';
  print(greeting.codeUnits.reversed);
  // Unicode's
  const dart = '🎯';
  print(dart.runes);
  print(dart.codeUnits);
  const flag = '🇲🇳';
  print(flag.runes);
  const family = '👨‍👩‍👧‍👦';
  print(family.runes);
  print(family.length);
  print(family.codeUnits.length);
  print(family.runes.length);
  print(family.characters.length);
  // Concatenation
  final message = StringBuffer();
  message.write('Hello');
  message.write(' my name is ');
  message.write('Ray');
  print(message.toString());
  // Interpolation
  const name = 'Ray';
  const  introduction = 'Hello my name is $name';
  print(introduction);
  const oneThird = 1 / 3;
  final sentence = 'One third is ${oneThird.toStringAsFixed(3)}';
  print(sentence);
  print('I \u2764 Dart\u0021');*/
  /*// Mini-exercises
  const firstName = 'Kelvin ';
  const lastName = 'Eduful';
  const fullName = firstName + lastName;
  const myDetails = 'Hello, my name is $fullName';
  print(myDetails);*/
  /*// Challenge 1
  final studentGrade;
  const attendance = 20 /100;
  const homeWork = 30 /100;
  const exam = 50 / 100;

  studentGrade = ((attendance * 90) + (homeWork * 80) + (exam * 94));
  print(studentGrade);*/
  /*// Challenge 2
  const twoCountries = '🇹🇩🇷🇴';
  print(twoCountries.runes);*/
  /*// Challenge 3
  const vote = 'Thumbs up! 👍🏿';
  print(vote.codeUnits.length); // code units
  print(vote.runes.length); // Unicode code points
  print(vote.characters.length); // Unicode grapheme clusters*/
  // Challenge 6
  const number = 10;
  const multiplier = 5;
  final summary = '$number \u00D7 $multiplier = ${number * multiplier}';
  print(summary);
}
