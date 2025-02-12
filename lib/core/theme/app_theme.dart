import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionui/core/theme/color_palete.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get getDarkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorPalete.scaffoldBackgroundColor,
        textTheme: TextTheme(
          titleMedium: GoogleFonts.inriaSerif(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.inriaSerif(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: _border(),
          focusedBorder: _border(ColorPalete.gradient2),
          contentPadding: EdgeInsets.all(27),
          focusedErrorBorder: _border(ColorPalete.gradient3),
          errorBorder: _border(ColorPalete.gradient3),
          disabledBorder: _border(),
        ),
      );
  static _border([Color color = ColorPalete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
}
