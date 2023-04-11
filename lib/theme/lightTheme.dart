import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportivo/theme/colors.dart';

class LightTheme {
  static final data = ThemeData(
    scaffoldBackgroundColor: SportivoColors.lightBackground,
    primarySwatch: Colors.lightBlue,
    colorScheme: ColorScheme.light(),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black54,
      size: 20,
    ),
    textTheme: TextTheme(
      headlineMedium: GoogleFonts.openSans(
          fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineSmall:
          GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
      titleLarge: GoogleFonts.openSans(
          fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: GoogleFonts.openSans(
          fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleSmall: GoogleFonts.openSans(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      labelLarge: GoogleFonts.roboto(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      bodySmall: GoogleFonts.roboto(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelSmall: GoogleFonts.roboto(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    ),
  );
}
