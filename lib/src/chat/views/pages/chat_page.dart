import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:test_firestore/main.dart';
import 'package:test_firestore/src/authentication/services/auth_service.dart';
import 'package:test_firestore/src/chat/services/firebase_chat_service.dart';
import 'package:test_firestore/src/chat/views/pages/message_page.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/chat/models/conversation.dart';
import 'package:test_firestore/utils/constants/colors.dart';
import 'package:test_firestore/utils/constants/shadows.dart';
import 'package:test_firestore/utils/constants/sizes.dart';
import 'package:test_firestore/utils/storage/shared_prefs.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final FirebaseChat _chat = FirebaseChat(firebaseFirestore: _firestore);
  Stream<List<Conversation>>? _conversationStream;
  String _userID = "";

  @override
  void initState() {
    SharedPrefs.getString("user_id").then((val) {
      _userID = val;
      _conversationStream = _chat.conversationStream(userId: val);
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    // _conversationStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_conversationStream == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("New Message"),
        onPressed: () => context.push("/users"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<List<Conversation>>(
              stream: _conversationStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }

                return ListView.builder(
                  itemCount: (snapshot.data ?? []).length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    var receiver = (data.participants ?? []).firstWhere(
                        (e) => e.id != _userID,
                        orElse: () => ChatUser());
                    if (receiver.id == null) return const SizedBox.shrink();
                    return GestureDetector(
                      onTap: () {
                        context.push("/messages", extra: data);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusMd),
                          boxShadow: TShadows.primaryBoxShadow,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: const Icon(
                                Icons.message_rounded,
                                color: TColors.darkGrey,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  receiver.phone ?? "",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                SizedBox(
                                  width: 280.w,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data.lastMessage?.message ?? "N/A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      if (data.lastMessage?.timestamp != null)
                                        Text(
                                          dateFormat.format(
                                              data.lastMessage!.timestamp!),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
