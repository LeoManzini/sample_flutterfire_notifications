import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return "Account created";
    } on FirebaseAuthException catch(e) {
      return e.message.toString();
    } catch(e) {
      return e.toString();
    }
  }

  static Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "Login successful";
    } on FirebaseAuthException catch(e) {
      return e.message.toString();
    } catch(e) {
      return e.toString();
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> isLoggedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}