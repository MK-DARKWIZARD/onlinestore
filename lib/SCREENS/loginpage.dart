import 'package:flutter/material.dart';
import 'package:onlinestore/DATA/authprovider.dart';
import 'package:onlinestore/DATA/routes.dart';
import 'package:onlinestore/SCREENS/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                "SIGN-IN",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: [
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
                      Navigator.popAndPushNamed(context, registorPageRoute);
                    },
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        late String message;
                        final String email = _email.text.toString();
                        final String password = _password.text.toString();
                        if (email.isEmpty) {
                          message = "Enter Email";
                        } else if (password.isEmpty) {
                          message = "Enter Password";
                        } else {
                          message = await AuthProvider()
                              .signInUserWithEmailAndPassword(email, password);
                          //_email.text = "";
                          // _password.text = "";
                        }
                        if (message == "SUCCESS") {
                          message = AuthProvider().emailVerificationChecker();
                          if (message == "SUCCESS") {
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (route) =>
                                  false, // This predicate will always return false, removing all previous routes
                            );
                          } else {
                            Navigator.pushNamed(context, verifyemailPageRoute);
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(message),
                            margin: EdgeInsets.only(
                                // ignore: use_build_context_synchronously
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
                          fixedSize: const Size(100, 10)),
                      child: const Text(
                        "LOGIN",
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
