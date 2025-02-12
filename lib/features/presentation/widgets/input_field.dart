import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscue;
  final String? Function(dynamic)? validator;
  final bool enabled;
  const InputField({super.key, required this.hintText, required this.controller, this.isObscue = false, this.enabled = true, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: isObscue,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is Empty";
        }
        return validator != null ? validator!(value.trim()) : null;
      },
    );
  }
}
