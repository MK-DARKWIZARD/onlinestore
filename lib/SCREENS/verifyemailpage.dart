import 'package:flutter/material.dart';
import 'package:onlinestore/DATA/authprovider.dart';
import 'package:onlinestore/SCREENS/homepage.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifEmailPageState();
}

class _VerifEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: Colors.green,
                      size: 60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please Verify your Email",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Text("You'r almost there! We sent an email to"),
                  const Text(
                    "YourEmail@gmail.com",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                        right: MediaQuery.of(context).size.width * 0.1),
                    child: const Text(
                      "Just click on the link in that email to complete you signup. If you don't see it, you may need to check you spam folder",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () async {
                        late String message;
                        message = AuthProvider().emailVerificationChecker();
                        if (message == "SUCCESS") {
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false,
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Error"),
                            margin: EdgeInsets.only(
                                // ignore: use_build_context_synchronously
                                bottom: MediaQuery.of(context).size.height - 85,
                                left: 10,
                                right: 10),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                      },
                      child: const Text(
                        "Already Verified",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Still can't find email! No Problem"),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () async {
                        late String message;
                        message =
                            await AuthProvider().sendEmailVerificationLink();
                        if (message == "SUCCESS") {
                          message = "Send successfuly";
                        } else {
                          message = "Wait for few minutes";
                        }
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(message.toString()),
                          margin: EdgeInsets.only(
                              // ignore: use_build_context_synchronously
                              bottom: MediaQuery.of(context).size.height - 85,
                              left: 10,
                              right: 10),
                          behavior: SnackBarBehavior.floating,
                        ));
                      },
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
