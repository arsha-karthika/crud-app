import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/AuthController.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailResetController = TextEditingController();

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    _rememberMe = value!;
                  },
                ),
                Text('Remember Me'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                authController.loginUser(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                _showForgotPasswordDialog(context);
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset Password'),
          content: TextField(
            controller: emailResetController,
            decoration: InputDecoration(labelText: 'Enter your email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                authController.resetPassword(emailResetController.text);
                Get.back();
              },
              child: Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
