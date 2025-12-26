import 'package:contact_book/src/features/user/data/datasources/local_user_datasource.dart';
import 'package:contact_book/src/features/user/data/models/user_model.dart';
import 'package:contact_book/src/features/user/domain/entities/user_entity.dart';
import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';

class UserRepoImpl implements UserRepository {
  final LocalUserDatasource local;
  UserRepoImpl(this.local);
  @override
  List<UserEntity> getusers() {
    return local.getusers();
  }

  @override
  Future<void> addUser(UserEntity user) async {
    await local.addUser(
      UserModel(
        id: user.id,
        name: user.name,
        phone: user.phone,
        age: user.age,
        imagepath: user.imagepath,
      ),
    );
  }
}
