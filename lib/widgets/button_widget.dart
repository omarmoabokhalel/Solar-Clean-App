import 'package:solar_clean/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.email,
    required this.password,
    required this.onPressed,
    required this.title,
  });
  final String title;
  final TextEditingController email;
  final TextEditingController password;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                onPressed?.call(); // نفذ الفانكشن
              },

              color: AppColors.primary,
              child: Text(title, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
