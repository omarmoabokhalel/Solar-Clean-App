import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  InputWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.obscureText
  });
  IconData icon;
  String hintText;
  TextEditingController controller = TextEditingController();
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          label: Text(hintText),
          prefixIcon: Icon(icon),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          counterStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 63, 35, 165),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: EdgeInsets.all(4),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
