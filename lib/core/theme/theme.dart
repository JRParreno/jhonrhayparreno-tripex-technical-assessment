import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/theme/app_pallete.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      titleTextStyle:
          const AppBarTheme().titleTextStyle?.copyWith(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppPallete.greyColor,
      ),
      fillColor: AppPallete.whiteColor,
      filled: true,
      contentPadding: const EdgeInsets.all(27),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppPallete.greyColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppPallete.primaryColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: AppPallete.primaryColor,
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          color: AppPallete.whiteColor,
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
      ),
    ),
    textTheme: TextTheme(
      labelSmall: GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.aBeeZee(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.aBeeZee(
        fontSize: 19,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
      titleMedium: GoogleFonts.montserrat(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 38,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
