class Person {
  late String name;
  late int age;

  Person(String name, int age) {
    this.name = name;
    this.age = age;
  }
  void introduce() {
    print('My name is ${name}');
  }
}
