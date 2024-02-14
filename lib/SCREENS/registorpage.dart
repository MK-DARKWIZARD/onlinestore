import 'package:flutter/material.dart';
import 'package:onlinestore/DATA/authprovider.dart';
import 'package:onlinestore/DATA/routes.dart';
import 'package:onlinestore/SCREENS/verifyemailpage.dart';

class RegistorPage extends StatefulWidget {
  const RegistorPage({super.key});

  @override
  State<RegistorPage> createState() => _RegistorpageState();
}

class _RegistorpageState extends State<RegistorPage> {
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: null,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [],
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                "SIGN-UP",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: [
                  TextField(
                    controller: _username,
                    decoration: const InputDecoration(
                      hintText: "Username",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, loginPageRoute);
                    },
                    child: const Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String message;
                        final String username = _username.text.toString();
                        final String email = _email.text.toString();
                        final String password = _password.text.toString();
                        if (username.isEmpty) {
                          message = "Enter Username";
                        } else if (email.isEmpty) {
                          message = "Enter Email";
                        } else if (password.isEmpty) {
                          message = "Enter Password";
                        } else if (password.length < 8) {
                          message = "Weak Password";
                        } else {
                          message = await AuthProvider()
                              .createUserWithEmailAndpassword(email, password);
                        }
                        if (message == "SUCCESS") {
                          message =
                              await AuthProvider().sendEmailVerificationLink();
                          if (message == "SUCCESS") {
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VerifyEmailPage()),
                              (route) =>
                                  false, // This predicate will always return false, removing all previous routes
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(message),
                            margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height - 85,
                                left: 10,
                                right: 10),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
