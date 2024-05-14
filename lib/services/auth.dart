import 'package:english_app/Widgets/MyToast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    bool result = true;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      result = false;
      showToast("Your email or password is incorrect");
    }
    return result;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // signUp with email and password
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showToast(e.message.toString());
    }
  }
}
