import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/chat/services/firebase_chat_service.dart';
import 'package:test_firestore/src/home/providers/users_provider.dart';
import 'package:test_firestore/utils/constants/colors.dart';
import 'package:test_firestore/utils/storage/shared_prefs.dart';

class UsersPages extends ConsumerStatefulWidget {
  const UsersPages({super.key});

  @override
  ConsumerState<UsersPages> createState() => _UsersPagesState();
}

class _UsersPagesState extends ConsumerState<UsersPages> {
  bool _loading = false;

  Widget _buildListView(List<ChatUser> _users) {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.person_outline_rounded,
            size: 40.h,
            color: TColors.darkGrey,
          ),
          title: Text(
            "${_users[index].phone}",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subtitle: Text(
            "Tap to start conversation",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () async {
            try {
              setState(() {
                _loading = true;
              });
              var userID = await SharedPrefs.getString("user_id");
              var conversation = await FirebaseChat(
                      firebaseFirestore: FirebaseFirestore.instance)
                  .startConversation(
                      recipientIdOrEmail: _users[index].id ?? "",
                      senderIdOrEmail: userID);
              context.go('/messages', extra: conversation);
            } catch (e) {
              Fluttertoast.showToast(msg: e.toString());
            } finally {
              setState(() {
                _loading = false;
              });
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var usersState = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: switch (usersState) {
        AsyncData(:final value) => _buildListView(value),
        AsyncError(:final error) => Text('Error: $error'),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
