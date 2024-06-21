import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_firestore/src/authentication/services/auth_service.dart';
import 'package:test_firestore/src/chat/services/firebase_chat_service.dart';
import 'package:test_firestore/main.dart';
import 'package:test_firestore/src/chat/views/widgets/message_widget.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/chat/models/conversation.dart';
import 'package:test_firestore/src/chat/models/message.dart';
import 'package:test_firestore/utils/constants/custom_textfields.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key, required this.conversation});
  Conversation conversation;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final FirebaseChat _chat = FirebaseChat(firebaseFirestore: _firestore);
  late Stream<List<Message>> _messagesStream;
  late ChatUser _recipient;
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    var recipient = (widget.conversation.participants ?? []).firstWhere(
      (e) => e.id != AuthService.instance.getCurrentUser()?.uid,
      orElse: () => ChatUser(),
    );
    if (recipient.id == null) {
      throw Exception("No Recipient found");
    }
    _recipient = recipient;
    _messagesStream =
        _chat.messageStream(id: widget.conversation.documentId ?? "");
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(_recipient.phone ?? ""),
            if ((_recipient.isOnline ?? false)) const Text("Online")
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height * 0.80),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<List<Message>>(
                    stream: _messagesStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var messages = (snapshot.data ?? []).reversed.toList();

                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) => MessageWidget(
                            message: messages[index],
                            conversation: widget.conversation),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TCustomTextFields.textFieldOne(
                          context, _messageController,
                          hintText: "Enter your message"),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (widget.conversation.documentId == null) return;
                          if (_messageController.text.isEmpty) return;

                          _chat
                              .sendMessage(
                                  message: Message(
                                    message: _messageController.text,
                                    senderId: AuthService.instance
                                        .getCurrentUser()
                                        ?.uid,
                                    recipientId: _recipient.id ?? "",
                                  ),
                                  id: widget.conversation.documentId ?? "")
                              .then((_) => setState(() {
                                    _messageController.clear();
                                  }));
                        },
                        child: const Icon(Icons.send))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
