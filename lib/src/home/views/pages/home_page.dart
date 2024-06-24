import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_firestore/main.dart';
import 'package:test_firestore/src/authentication/services/auth_service.dart';
import 'package:test_firestore/src/authentication/services/firestore_service.dart';
import 'package:test_firestore/utils/notification/cloud_messaging_service.dart';
import 'package:test_firestore/utils/notification/notification_service.dart';
import 'package:test_firestore/utils/storage/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _token;
  @override
  void initState() {
    LocalNotificationService.initialize();
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.getToken().then((token) async {
      if (token == null) return;
      _token = token;

      await FirestoreService(collection: "users").syncToken(token);
      setState(() {});
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: Text(msg.notification?.title ?? ""),
              content: Text(msg.notification?.body ?? ""),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"))
              ],
            );
          });
      LocalNotificationService.display(msg);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                AuthService.instance.signOut().then((_) {
                  SharedPrefs.setString("user_id", '');
                  context.go('/');
                });
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 80.h),
              child: Text(
                "Hello ${AuthService.instance.getCurrentUser()?.phoneNumber}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            ElevatedButton(
              onPressed: () => context.push('/chats'),
              child: const Text("Go to Conversations"),
            ),
            if (_token != null)
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: ElevatedButton(
                  onPressed: () {
                    CloudMessagingService().sendFcmMessage({
                      "message": {
                        "token": _token ?? "",
                        "notification": {
                          "body":
                              "This message is trigged from Home page at ${dateFormat.format(DateTime.now())}",
                          "title": "Notification Triggered by user",
                        }
                      }
                    });
                  },
                  child: const Text("Trigger a notification"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
