import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:test_firestore/utils/router/router.dart';
import 'package:test_firestore/utils/storage/shared_prefs.dart';
import 'package:test_firestore/utils/theme/theme.dart';

import 'firebase_options.dart';

// var currentUserID = "zxzCAPptuyR6hiLnOarK";
var dateFormat = DateFormat('MM/dd/yyyy hh:mm a');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirestoreService _firestoreService = FirestoreService(docID: "1111");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
          designSize: const Size(375, 801),
          splitScreenMode: false,
          minTextAdapt: true,
          builder: (context, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: TAppTheme.lightTheme,
              routerConfig: router,
            );
          }),
    );
  }
}
