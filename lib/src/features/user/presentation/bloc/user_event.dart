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

class searchUser extends UserEvent {
  final String query;
  searchUser({required this.query});
}

class sortolder extends UserEvent {}

class sortyounger extends UserEvent {}

class sortreset extends UserEvent {}

class loadmore extends UserEvent {}
