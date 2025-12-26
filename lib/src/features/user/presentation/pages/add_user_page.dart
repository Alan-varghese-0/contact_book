import 'package:contact_book/src/features/user/presentation/bloc/user_bloc.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namecontroller,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phonecontroller,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: agecontroller,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(
                  addUser(
                    name: namecontroller.text,
                    phone: phonecontroller.text,
                    age: int.parse(agecontroller.text),
                    imagepath: '',
                  ),
                );
                Navigator.pop(context);
              },
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
