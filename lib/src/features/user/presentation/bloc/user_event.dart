abstract class UserEvent {}

class loadUser extends UserEvent {}

class addUser extends UserEvent {
  final String name;
  final String phone;
  final int age;
  final String imagepath;
  addUser({
    required this.name,
    required this.phone,
    required this.age,
    required this.imagepath,
  });
}
