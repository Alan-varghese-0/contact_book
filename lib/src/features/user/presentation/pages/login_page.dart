import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:contact_book/src/features/user/presentation/pages/otp_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final UserRepository repo;
  LoginPage({super.key, required this.repo});
  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phonecontroller,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (phonecontroller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("please enter the phone number")),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OtpPage(phone: phonecontroller.text, repo: repo),
                  ),
                );
              },
              child: const Text('sent OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
