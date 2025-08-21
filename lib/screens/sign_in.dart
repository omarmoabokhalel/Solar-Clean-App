import 'dart:developer';
import 'package:solar_clean/screens/navigation.dart';
import 'package:solar_clean/widgets/app_colors.dart';
import 'package:solar_clean/widgets/button_widget.dart';
import 'package:solar_clean/widgets/input_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solar_clean/screens/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var email = TextEditingController();
  var password = TextEditingController();
  Future<void> signInWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      log("Logined Success: ${credential.user?.uid}");
      email.clear();
      password.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => MainNavigation()),
      );
    } on FirebaseAuthException catch (e) {
      log('Firebase Error: ${e.code} - ${e.message}'); // سجل الكود والرسالة

      String message;

      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'user-disabled':
          message = 'This user has been disabled.';
          break;
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Try again later.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password sign-in is not enabled.';
          break;
        case 'invalid-credential':
          message = 'The credentials are invalid or expired.';
          break;
        default:
          message = 'An unknown error occurred: ${e.code}';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Login",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 60,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 40),
          InputWidget(
            obscureText: false,
            hintText: "Email",
            icon: Icons.email_outlined,
            controller: email,
          ),
          SizedBox(height: 15),
          InputWidget(
            obscureText: true,
            hintText: "Password",
            icon: Icons.password,
            controller: password,
          ),
          SizedBox(height: 20),
          ButtonWidget(
            title: "Log In",
            email: email,
            password: password,
            onPressed: signInWithEmailAndPassword,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dont Have An Account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => SignUp()),
                  );
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
