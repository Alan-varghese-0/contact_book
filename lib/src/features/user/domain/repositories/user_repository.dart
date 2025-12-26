import 'package:contact_book/src/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  List<UserEntity> getusers();
  Future<void> addUser(UserEntity user);
}
