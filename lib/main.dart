import 'package:flutter/material.dart';
import 'package:onlinestore/DATA/routes.dart';
import 'package:onlinestore/SCREENS/homepage.dart';
import 'package:onlinestore/SCREENS/loginpage.dart';
import 'package:onlinestore/SCREENS/registorpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onlinestore/SCREENS/verifyemailpage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      loginPageRoute: (context) => const LoginPage(),
      registorPageRoute: (context) => const RegistorPage(),
      homePageRoute: (context) => const HomePage(),
      verifyemailPageRoute: (context) => const VerifyEmailPage()
    },
    home: const HomePage(),
  ));
}
