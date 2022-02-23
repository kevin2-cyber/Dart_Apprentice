import 'dart:math';

void main(List<String> arguments) {
  /// numbers
  // integers and floating-point numbers
  /*int age = 10;
  age += 15;
  print(age.isOdd);
  print(age.isEven);
  print(3.1459.round());
  print('I am $age years old ');
  num car = 20;
  car = 20.0;
  print(car.runtimeType);
  /// Using constants[Final amd const keyword]
  const myConst = 10;
  print(myConst.runtimeType);
  final hoursSinceMidnight = DateTime.now();
  print(hoursSinceMidnight);*/
  // mini exercise one
   /*
   const myAge = 19;
   const bestFriendAge = 17;
   double averageAge;
   averageAge = ((myAge + bestFriendAge) / 2);
   print(averageAge);
   const testNumber = 9;
   const evenOdd = testNumber % 2;
   print(evenOdd);*/
   /// Increment and decrement
   /*var incrementCounter = 0;
   incrementCounter += 1; // adds one to the current value and assigns the value back to the variable
   print(incrementCounter);
   var decrementCounter = 3;
   decrementCounter -= 1; // subtracts one from the current value and assigns the value back to the variable
   print(decrementCounter);
   double myValue = 10;
   myValue *= 3;
   print(myValue);
   myValue /= 2;
   print(myValue);*/
   /// Assignment one
   // Challenge 1
   const myAge = 19;
   int dogs = 12;
   dogs++;
   print(dogs);
   // Challenge 2
   var age = 16;
   print(age);
   age = 30;
   print(age);
   // Challenge 3
   const x = 46;
   const y = 10;
   const answer1 = (x * 100) + y;
   print(answer1);
   const answer2 = (x * 100) + (y * 100);
   print(answer2);
   const answer3 = (x * 100) + (y / 10);
   print(answer3);
   // Challenge 4
   const rating1 = 10;
   const rating2 = 12;
   const rating3 = 14;
   const averageRating = (rating1 + rating2 + rating3) / 3;
   print(averageRating);
   // Challenge 5
   String quad = 'ax2 + bx + c';
   double a = 20;
   double b = 10;
   double c = 5;
   double root1 = (-(b) + sqrt((b * b) - (4 * a * c))) / (2 * a);
   double root2 = (-(b) - sqrt((b * b) - (4 * a * c))) / (2 * a);
   print(root1);
   print(root2);
}
