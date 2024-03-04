class Person {
  // Fields
  String firstName;
  String lastName;
  int _age = 20;

  // Constructors
  Person({required this.firstName, required this.lastName});

  // Getters
  String get fullName => '$firstName $lastName';

  int get age => _age;

  // Setters
  set fullName(String value) {
    var parts = value.split(' ');
    if (parts.length == 2) {
      firstName = parts[0];
      lastName = parts[1];
    }
  }

  set setAge(int age) => _age = age;

  set setFirstName(String firstName) => firstName = firstName;

  set setLastName(String lastName) => lastName = lastName;
}

const List<String> firstNameList = ['Adam', 'Ivan', 'Sofia', 'Oleg', 'Nazar', 'Ostap', 'Mykola', 'Andrii', 'Volodymyr'];
const List<String> lastNameList = ['Ivaniush', 'Koval', 'Skachko', 'Klychko', 'Lishuk', 'Baidak', 'Bilyk', 'Novak', 'Kryvyi'];