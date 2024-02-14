import 'dart:developer' show log;
import 'package:onlinestore/DATA/authservices.dart';

class AuthProvider {
  createUserWithEmailAndpassword(final email, final password) async {
    String message;
    message = await AuthServices().createNewUser(email, password);
    if (message == "SUCCESS") {
      return "SUCCESS";
    } else if (message.contains("badly formatted")) {
      message = "Incorrect email format";
    } else if (message.contains("network")) {
      message = "Connection Error";
    } else if (message.contains("use by an other account")) {
      message = "The email address is already in use by another account.";
    } else {
      message = "Something went wrong";
    }
    return message;
  }

  signInUserWithEmailAndPassword(final email, final password) async {
    String message;
    message = await AuthServices().signInUser(email, password);
    if (message == "SUCCESS") return "SUCCESS";
    if (message.contains("badly formatted")) {
      message = "Incorrect email format";
    } else if (message.contains("The supplied auth credential is incorrect")) {
      message = "Email and Password don't match";
    } else if (message.contains("network")) {
      message = "Connection Error";
    } else {
      message = "Something went wrong";
    }
    return message;
  }

  sendEmailVerificationLink() async {
    late String message;
    try {
      message = await AuthServices().userEmailVerification();
      if (message == "SUCCESS") {
        return "SUCCESS";
      } else {
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }

  emailVerificationChecker() {
    late bool? verificationstatus;
    try {
      verificationstatus = AuthServices().isEmailVerified();
      if (verificationstatus == true) {
        return "SUCCESS";
      } else {
        log("message");
        return "ERROR";
      }
    } catch (e) {
      return "ERROR";
    }
  }
}
