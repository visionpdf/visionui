import 'package:flutter/material.dart';
import 'package:visionui/core/theme/color_palete.dart';

class GradientButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const GradientButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalete.gradient1,
              ColorPalete.gradient2,
              ColorPalete.gradient3,
            ],
          ),
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
