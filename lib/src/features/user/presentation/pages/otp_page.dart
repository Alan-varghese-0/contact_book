import 'package:contact_book/src/features/user/domain/repositories/user_repository.dart';
import 'package:contact_book/src/features/user/presentation/pages/user_list_pages.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  final UserRepository repo;
  final String phone;
  OtpPage({super.key, required this.phone, required this.repo});
  final otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("verify OTP")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("An OTP has been sent to $phone"),
            SizedBox(height: 20),
            TextField(
              controller: otpcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (otpcontroller.text == "1234") {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserListPages(repo: repo);
                      },
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Invalid OTP")));
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
