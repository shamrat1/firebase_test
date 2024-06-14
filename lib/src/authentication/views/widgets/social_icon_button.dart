import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firestore/utils/constants/shadows.dart';
import 'package:test_firestore/utils/constants/sizes.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({super.key, required this.assetImageURL});
  final String assetImageURL;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        boxShadow: TShadows.primaryBoxShadow,
      ),
      alignment: Alignment.center,
      child: Image.asset(
        assetImageURL,
        height: 22.h,
        width: 22.h,
      ),
    );
  }
}
