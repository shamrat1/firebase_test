import 'package:go_router/go_router.dart';
import 'package:test_firestore/src/chat/models/conversation.dart';
import 'package:test_firestore/src/authentication/services/auth_service.dart';
import 'package:test_firestore/src/authentication/views/pages/otp_page.dart';
import 'package:test_firestore/src/authentication/views/pages/phone_verify.dart';
import 'package:test_firestore/src/chat/views/pages/chat_page.dart';
import 'package:test_firestore/src/chat/views/pages/message_page.dart';
import 'package:test_firestore/src/home/views/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) {
    if (AuthService.instance.getCurrentUser() == null &&
        !state.uri.path.contains("otp")) {
      return '/';
    }
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PhoneVerifyPage(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OtpPage(
        phone: (state.extra as Map<String, String>)['phone'] ?? "",
        verificationId:
            (state.extra as Map<String, String>)['verificationID'] ?? "",
      ),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/chats',
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: '/messages',
      builder: (context, state) {
        return MessagePage(conversation: state.extra as Conversation);
      },
    ),
  ],
);
