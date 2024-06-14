import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/colors.dart';

/// Custom Class for Light & Dark Text Themes
class TTextTheme {
  TTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: GoogleFonts.lato(
        fontSize: 32.sp, fontWeight: FontWeight.bold, color: TColors.dark),
    headlineMedium: GoogleFonts.lato(
        fontSize: 24.sp, fontWeight: FontWeight.w600, color: TColors.dark),
    headlineSmall: GoogleFonts.lato(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: TColors.dark),
    titleLarge: GoogleFonts.lato(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: TColors.dark),
    titleMedium: GoogleFonts.lato(
        fontSize: 16.sp, fontWeight: FontWeight.w500, color: TColors.dark),
    titleSmall: GoogleFonts.lato(
        fontSize: 16.sp, fontWeight: FontWeight.w400, color: TColors.dark),
    bodyLarge: GoogleFonts.lato(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: TColors.dark),
    bodyMedium: GoogleFonts.lato(
        fontSize: 14.sp, fontWeight: FontWeight.normal, color: TColors.dark),
    bodySmall: GoogleFonts.lato(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: TColors.dark.withOpacity(0.5)),
    labelLarge: GoogleFonts.lato(
        fontSize: 12.sp, fontWeight: FontWeight.normal, color: TColors.dark),
    labelMedium: GoogleFonts.lato(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: TColors.dark.withOpacity(0.5)),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.lato(
        fontSize: 32.sp, fontWeight: FontWeight.bold, color: TColors.light),
    headlineMedium: GoogleFonts.lato(
        fontSize: 24.sp, fontWeight: FontWeight.w600, color: TColors.light),
    headlineSmall: GoogleFonts.lato(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: TColors.light),
    titleLarge: GoogleFonts.lato(
        fontSize: 16.sp, fontWeight: FontWeight.w600, color: TColors.light),
    titleMedium: GoogleFonts.lato(
        fontSize: 16.sp, fontWeight: FontWeight.w500, color: TColors.light),
    titleSmall: GoogleFonts.lato(
        fontSize: 16.sp, fontWeight: FontWeight.w400, color: TColors.light),
    bodyLarge: GoogleFonts.lato(
        fontSize: 14.sp, fontWeight: FontWeight.w500, color: TColors.light),
    bodyMedium: GoogleFonts.lato(
        fontSize: 14.sp, fontWeight: FontWeight.normal, color: TColors.light),
    bodySmall: GoogleFonts.lato(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: TColors.light.withOpacity(0.5)),
    labelLarge: GoogleFonts.lato(
        fontSize: 12.sp, fontWeight: FontWeight.normal, color: TColors.light),
    labelMedium: GoogleFonts.lato(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: TColors.light.withOpacity(0.5)),
  );
}
