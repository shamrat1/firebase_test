import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_firestore/src/authentication/services/auth_service.dart';
import 'package:test_firestore/src/authentication/views/widgets/social_icon_button.dart';
import 'package:test_firestore/utils/constants/custom_textfields.dart';

class OtpPage extends StatefulWidget {
  String phone;
  String verificationId;
  OtpPage({super.key, required this.phone, required this.verificationId});

  @override
  State<OtpPage> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  String? _otpError;
  bool _loading = false;
  bool _validate() {
    if (_otpController.text == "") {
      _otpError = "OTP is required";
    } else if (_otpController.text.length != 6) {
      _otpError = "Enter 6 digit OTP to continue";
    } else {
      _otpError = null;
    }

    setState(() {});

    if (_otpError == null) {
      return true;
    }
    return false;
  }

  Widget _errorWidget(String? error) {
    if (error == null) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.only(top: 8.h),
      alignment: Alignment.centerLeft,
      child: Text(
        error,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 83.h),
                child: Image.asset(
                  "assets/logo.png",
                  height: 100.h,
                  width: 165.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: Text(
                  "Verify OTP",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    TCustomTextFields.textFieldOne(
                      context,
                      _otpController,
                      prefixIcon: Icons.password,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      hintText: "OTP",
                    ),
                    _errorWidget(_otpError),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Edit ${widget.phone}?",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_loading) return;
                    try {
                      setState(() {
                        _loading = true;
                      });
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: _otpController.text);
                      AuthService.instance.signInWithCredential(credential);
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    } finally {
                      setState(() {
                        _loading = true;
                      });
                    }
                  },
                  child: const Text("Verify"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 55.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const SocialIconButton(
                          assetImageURL: "assets/facebook.png"),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const SocialIconButton(
                          assetImageURL: "assets/google.png"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
