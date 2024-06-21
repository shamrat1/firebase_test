import 'dart:convert';

class Message {
  String? id;
  String? message;
  String? senderId;
  String? recipientId;
  String? status;
  DateTime? timestamp;
  String? type;

  Message({
    this.id,
    this.message,
    this.senderId,
    this.recipientId,
    this.status,
    this.timestamp,
    this.type,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      message: map['message'],
      senderId: map['senderId'],
      recipientId: map['recipientId'],
      status: map['status'],
      type: map['type'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  factory Message.fromJSON(String jsonString) {
    return Message.fromMap(json.decode(jsonString));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'senderId': senderId,
      'recipientId': recipientId,
      'status': status,
      'type': type,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }

  String toJSON() => json.encode(toMap());
}
