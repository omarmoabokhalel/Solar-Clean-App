import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solar_clean/screens/sign_in.dart';
import 'package:solar_clean/widgets/app_colors.dart';
import 'package:solar_clean/widgets/input_widget.dart';
import 'package:solar_clean/widgets/button_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      log("User created: ${credential.user?.uid}");

      email.clear();
      password.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuth Error: ${e.code} - ${e.message}');
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already in use.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          message = 'The password is too weak. Try something stronger.';
          break;
        default:
          message = 'Error: ${e.code}';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      log('Unexpected Error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unexpected error occurred")),
      );
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
            "Sign Up",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 60,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 40),
          InputWidget(
            obscureText: false,
            hintText: "Email",
            icon: Icons.email_outlined,
            controller: email,
          ),
          const SizedBox(height: 15),
          InputWidget(
            obscureText: true,
            hintText: "Password",
            icon: Icons.password,
            controller: password,
          ),
          const SizedBox(height: 20),
          ButtonWidget(
            title: "Sign Up",
            email: email,
            password: password,
            onPressed: createUserWithEmailAndPassword,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already Have An Account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                },
                child: Text(
                  "Login Now",
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
