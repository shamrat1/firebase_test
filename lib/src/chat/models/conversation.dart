import 'dart:convert';

import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/chat/models/message.dart';

class Conversation {
  List<ChatUser>? participants;
  List<String>? participantsIds;
  String? initiatedBy;
  DateTime? initiatedAt;
  DateTime? lastUpdatedAt;
  String? documentId;
  Message? lastMessage;

  Conversation({
    this.participants,
    this.initiatedBy,
    this.initiatedAt,
    this.lastUpdatedAt,
    this.documentId,
    this.participantsIds,
    this.lastMessage,
  });

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      participants: List<ChatUser>.from(
          map['participants']?.map((x) => ChatUser.fromMap(x))),
      participantsIds: List<String>.from(map['participantsIds']),
      initiatedBy: map['initiatedBy'],
      initiatedAt: DateTime.parse(map['initiatedAt']),
      lastUpdatedAt: DateTime.fromMillisecondsSinceEpoch(map['lastUpdatedAt']),
      documentId: map['documentId'],
      lastMessage: Message.fromMap(map['lastMessage']),
    );
  }

  factory Conversation.fromJSON(String jsonString) {
    return Conversation.fromMap(json.decode(jsonString));
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants?.map((x) => x.toMap()).toList(),
      'participantsIds': participantsIds,
      'initiatedBy': initiatedBy,
      'initiatedAt': initiatedAt?.millisecondsSinceEpoch,
      'lastUpdatedAt': lastUpdatedAt?.millisecondsSinceEpoch,
      'documentId': documentId,
      'lastMessage': lastMessage?.toMap(),
    };
  }

  String toJSON() => json.encode(toMap());
}
