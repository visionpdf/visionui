import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscure;
  final String? Function(String)? validator;
  final bool? enabled;
  final double? cursorHeight;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;

  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;

  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscure,
    this.enabled,
    this.validator,
    this.cursorHeight,
    this.textAlign,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
    this.border,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      enabled: enabled ?? true,
      controller: controller,
      obscureText: isObscure ?? false,
      cursorHeight: cursorHeight,
      textAlign: textAlign ?? TextAlign.start, // Default to left-aligned
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        border: border,
      ),
      style: textStyle ??
          const TextStyle(
            color: Colors.white,
          ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$hintText is Empty";
        }
        return validator != null ? validator!(value.trim()) : null;
      },
    );
  }
}
