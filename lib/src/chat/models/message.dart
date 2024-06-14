import 'dart:convert';

class Message {
  String? message;
  String? senderId;
  String? recipientId;
  String? status;
  DateTime? timestamp;

  Message({
    this.message,
    this.senderId,
    this.recipientId,
    this.status,
    this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      senderId: map['senderId'],
      recipientId: map['recipientId'],
      status: map['status'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  factory Message.fromJSON(String jsonString) {
    return Message.fromMap(json.decode(jsonString));
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'recipientId': recipientId,
      'status': status,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  String toJSON() => json.encode(toMap());
}
