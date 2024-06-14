import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_firestore/main.dart';
import 'package:test_firestore/src/authentication/services/auth_service.dart';
import 'package:test_firestore/src/chat/models/conversation.dart';
import 'package:test_firestore/src/chat/models/message.dart';

class MessageWidget extends StatefulWidget {
  MessageWidget({super.key, required this.message, required this.conversation});
  Message message;
  Conversation conversation;
  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool isMyMessage = false;
  bool _showAdditionInfo = false;
  @override
  void initState() {
    isMyMessage =
        widget.message.senderId == AuthService.instance.getCurrentUser()?.uid;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showAdditionInfo = !_showAdditionInfo;
        });
      },
      child: Column(
        crossAxisAlignment:
            isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          BubbleSpecialThree(
            text: widget.message.message ?? "",
            isSender: isMyMessage,
            color: isMyMessage ? Colors.white : Colors.blue.shade500,
            textStyle: TextStyle(
              color: isMyMessage ? Colors.black : Colors.white,
              fontSize: 16,
            ),
          ),
          if (_showAdditionInfo)
            Padding(
              padding: EdgeInsets.only(
                  right: isMyMessage ? 20 : 0,
                  left: isMyMessage ? 0 : 20,
                  bottom: 8),
              child: Text(
                dateFormat.format(widget.message.timestamp!),
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            )
        ],
      ),
    );
  }
}
