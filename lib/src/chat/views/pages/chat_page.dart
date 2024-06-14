import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_firestore/src/authentication/services/auth_service.dart';
import 'package:test_firestore/src/chat/services/firebase_chat_service.dart';
import 'package:test_firestore/main.dart';
import 'package:test_firestore/src/chat/views/pages/message_page.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/chat/models/conversation.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final FirebaseChat _chat = FirebaseChat(firebaseFirestore: _firestore);
  late Stream<List<Conversation>> _conversationStream;

  @override
  void initState() {
    _conversationStream = _chat.conversationStream(
        userId: AuthService.instance.getCurrentUser()?.uid ?? "");
    super.initState();
  }

  @override
  void dispose() {
    // _conversationStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _chat.startConversation(
              recipientIdOrEmail: "fgWXWDITmRQrlkhhXtPT",
              senderIdOrEmail:
                  AuthService.instance.getCurrentUser()?.uid ?? "");
        },
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
                // if (snapshot.connectionState != ConnectionState.done) {
                //   return const Center(
                //     child: Text("Failed to load"),
                //   );
                // }

                return ListView.builder(
                  itemCount: (snapshot.data ?? []).length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    var receiver = (data.participants ?? []).firstWhere(
                        (e) =>
                            e.id != AuthService.instance.getCurrentUser()?.uid,
                        orElse: () => ChatUser());
                    if (receiver.id == null) return const SizedBox.shrink();
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => MessagePage(conversation: data),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade100,
                                blurRadius: 5,
                                spreadRadius: 5),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(receiver.name ?? ""),
                            Text(data.lastMessage?.message ?? "N/A")
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