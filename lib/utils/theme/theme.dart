import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firestore/utils/constants/sizes.dart';
import 'package:test_firestore/utils/theme/widget_themes/appbar_theme.dart';
import 'package:test_firestore/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:test_firestore/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:test_firestore/utils/theme/widget_themes/chip_theme.dart';
import 'package:test_firestore/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:test_firestore/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:test_firestore/utils/theme/widget_themes/text_field_theme.dart';
import 'package:test_firestore/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    disabledColor: TColors.grey,
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: TColors.primaryBackground,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      sizeConstraints: BoxConstraints(
          minWidth: 100.w, maxWidth: 150.w, minHeight: 40.h, maxHeight: 60.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
      ),
      backgroundColor: TColors.primary,
      iconSize: TSizes.iconMd,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: TColors.light,
      selectedIconTheme: IconThemeData(
        size: TSizes.iconMd,
        color: TColors.primary,
      ),
      unselectedIconTheme: IconThemeData(
        size: TSizes.iconSm,
        color: TColors.darkGrey,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.grey,
    brightness: Brightness.dark,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: TColors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
