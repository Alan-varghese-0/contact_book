import 'package:contact_book/src/core/services/hive_service.dart';
import 'package:contact_book/src/features/user/data/datasources/local_user_datasource.dart';
import 'package:contact_book/src/features/user/data/repositories/user_repo_impl.dart';
import 'package:contact_book/src/features/user/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = LocalUserDatasource(HiveService.usersBox);
    final repo = UserRepoImpl(datasource);
    return MaterialApp(
      title: "user App",
      debugShowCheckedModeBanner: false,
      home: LoginPage(repo: repo),
    );
  }
}
