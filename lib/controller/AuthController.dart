import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  Future<void> registerUser(String email, String password, String name, String avatarUrl) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.updatePhotoURL(avatarUrl);
      Get.snackbar('Registration Successful', 'Welcome, $name!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Login Successful', 'Welcome back!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Password Reset', 'Check your email for the reset link');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void handleMultipleSessions() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _user.value = user;
      }
    });
  }

  // Sign out the user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
