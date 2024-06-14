import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firestore/utils/constants/colors.dart';
import 'package:test_firestore/utils/constants/shadows.dart';
import 'package:test_firestore/utils/constants/sizes.dart';

class TCustomTextFields {
  static Widget textFieldOne(
    BuildContext context,
    TextEditingController controller, {
    IconData? prefixIcon,
    String? hintText,
    TextInputAction? textInputAction,
    bool obsecureText = false,
    String? Function(String?)? validator,
    TextInputType? textInputType,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        boxShadow: TShadows.primaryBoxShadow,
      ),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        obscureText: obsecureText,
        textInputAction: textInputAction,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: TColors.darkGrey,
              ),
          errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.red,
              ),
          prefixIcon: prefixIcon == null
              ? null
              : Icon(
                  prefixIcon,
                  color: TColors.darkGrey,
                ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
