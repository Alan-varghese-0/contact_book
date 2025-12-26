import 'package:contact_book/src/features/user/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapter
    Hive.registerAdapter(UserModelAdapter());

    // Open Box
    await Hive.openBox<UserModel>('usersBox');
  }

  static Box<UserModel> get usersBox => Hive.box<UserModel>('usersBox');
}
