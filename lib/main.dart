import 'package:contact_book/app.dart';
import 'package:contact_book/src/core/services/hive_service.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const MyApp());
}
