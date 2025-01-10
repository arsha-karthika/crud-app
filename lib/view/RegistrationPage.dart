import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/AuthController.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: avatarController,
              decoration: InputDecoration(labelText: 'Avatar URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authController.registerUser(
                  emailController.text,
                  passwordController.text,
                  nameController.text,
                  avatarController.text,
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
