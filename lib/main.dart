import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:test_firestore/utils/router/router.dart';
import 'package:test_firestore/utils/storage/shared_prefs.dart';
import 'package:test_firestore/utils/theme/theme.dart';

import 'firebase_options.dart';

var dateFormat = DateFormat('MM/dd/yyyy hh:mm a');

Future<void> foregroundMsgHandler(RemoteMessage msg) async {
  print(msg.notification?.title ?? "Title");
  print(msg.notification?.body ?? "Body");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefs.init();
  FirebaseMessaging.onBackgroundMessage(foregroundMsgHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
