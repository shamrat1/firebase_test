import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_firestore/src/authentication/views/widgets/social_icon_button.dart';
import 'package:test_firestore/utils/constants/colors.dart';
import 'package:test_firestore/utils/constants/custom_textfields.dart';

class PhoneVerifyPage extends StatefulWidget {
  const PhoneVerifyPage({super.key});

  @override
  State<PhoneVerifyPage> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? _phoneError;
  bool _loading = false;
  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp regex = RegExp(r'^01\d{9}$');
    return regex.hasMatch(phoneNumber);
  }

  bool _validate() {
    if (_phoneController.text == "") {
      _phoneError = "Phone no is required";
    } else if (!isValidPhoneNumber(_phoneController.text)) {
      _phoneError = "Enter a valid Phone no.";
    } else {
      _phoneError = null;
    }
    setState(() {});

    if (_phoneError == null) {
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
                  "Sign In",
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
                      _phoneController,
                      prefixIcon: Icons.phone,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      hintText: "Phone",
                    ),
                    _errorWidget(_phoneError),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_validate()) {
                      setState(() {
                        _loading = true;
                      });
                      await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+88${_phoneController.text}",
                          verificationCompleted: _signInWithCredential,
                          verificationFailed: (FirebaseAuthException e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message ?? "")));
                          },
                          codeSent: (String verficationID, int? resendToken) {
                            context.push("/otp", extra: {
                              "phone": _phoneController.text,
                              "verificationID": verficationID
                            });
                            setState(() {
                              _loading = true;
                            });
                          },
                          codeAutoRetrievalTimeout: (val) {});
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                  child: _loading
                      ? const CircularProgressIndicator()
                      : const Text("Send OTP"),
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

  void _signInWithCredential(PhoneAuthCredential credential) {
    FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      print("=====================+++===================");
      print("new User ? ${value.additionalUserInfo?.isNewUser ?? false}");

      print(value.user?.phoneNumber);
      print(value.credential?.accessToken);
    });
  }
}
