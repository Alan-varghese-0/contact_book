import 'package:contact_book/src/features/user/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends UserEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final int age;
  @HiveField(4)
  final String imagepath;
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.imagepath,
  }) : super(id: id, name: name, phone: phone, age: age, imagepath: imagepath);
}
