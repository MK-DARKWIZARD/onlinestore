import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  Future<String> createNewUser(final email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signInUser(final email, final password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "SUCCESS";
    } catch (e) {
      return e.toString();
    }
  }

  userEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      try {
        await user!.sendEmailVerification();
      } catch (e) {
        return "ERROR";
      }
      return "SUCCESS";
    } catch (e) {
      return "ERROR";
    }
  }

  isEmailVerified() {
    try {
      bool? status;
      status = _auth.currentUser?.emailVerified;
      return status;
    } catch (e) {
      return false;
    }
  }
}
