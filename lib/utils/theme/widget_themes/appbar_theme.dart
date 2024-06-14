import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firestore/utils/constants/sizes.dart';
import '../../constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.black, size: TSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: TColors.textPrimary, size: TSizes.iconMd),
    // titleTextStyle: TextStyle(
    //     fontSize: 18.0, fontWeight: FontWeight.w600, color: TColors.black),
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: TColors.textPrimary,
    ),
  );
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.black, size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: TColors.white, size: TSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.sp, fontWeight: FontWeight.w600, color: TColors.white),
  );
}
