import 'package:contact_book/src/features/user/presentation/bloc/user_bloc.dart';
import 'package:contact_book/src/features/user/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  File? imagefile;
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final agecontroller = TextEditingController();

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imagefile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 45,
                backgroundImage: imagefile != null
                    ? FileImage(imagefile!)
                    : null,
                child: imagefile == null
                    ? const Icon(Icons.add_a_photo, size: 30)
                    : null,
              ),
            ),
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
                    imagepath: imagefile?.path ?? '',
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
