import 'package:contact_book/src/features/user/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalUserDatasource {
  final Box<UserModel> userBox;
  LocalUserDatasource(this.userBox);

  List<UserModel> getusers() {
    return userBox.values.toList();
  }

  Future<void> addUser(UserModel user) async {
    await userBox.put(user.id, user);
  }
}
