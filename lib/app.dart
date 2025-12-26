import 'package:contact_book/src/core/services/hive_service.dart';
import 'package:contact_book/src/features/user/data/datasources/local_user_datasource.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = LocalUserDatasource(HiveService.usersBox);
    return MaterialApp(
      title: "user App",
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: Center(child: Text("Hello, User!"))),
    );
  }
}
