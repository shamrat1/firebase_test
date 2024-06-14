import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_firestore/src/chat/models/chat_user.dart';
import 'package:test_firestore/src/chat/models/conversation.dart';
import 'package:test_firestore/src/chat/models/message.dart';
import 'package:validators/validators.dart';

class FirebaseChat {
  FirebaseChat({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;
  final FirebaseFirestore _firebaseFirestore;

  Future<Conversation> startConversation({
    required String recipientIdOrEmail,
    required String senderIdOrEmail,
    ChatUser? currentUser,
  }) async {
    try {
      late final QuerySnapshot<Map<String, dynamic>> userDocument;
      late final QuerySnapshot<Map<String, dynamic>> senderDocument;

      // throw exception if user is trying to start conversation with
      // themself
      if (senderIdOrEmail == recipientIdOrEmail) {
        throw Exception('You cannot chat with yourself.');
      }

      // user is trying to start conversation with a user with their email
      if (isEmail(recipientIdOrEmail)) {
        userDocument = await _firebaseFirestore
            .collection('users')
            .where(
              'email',
              isEqualTo: recipientIdOrEmail,
            )
            .get();
      }
      // user is trying to start conversation with a user with their mID
      else {
        userDocument = await _firebaseFirestore
            .collection('users')
            .where(
              'id',
              isEqualTo: recipientIdOrEmail,
            )
            .get();
      }
      if (isEmail(senderIdOrEmail)) {
        senderDocument = await _firebaseFirestore
            .collection('users')
            .where(
              'email',
              isEqualTo: senderIdOrEmail,
            )
            .get();
      }
      // user is trying to start conversation with a user with their mID
      else {
        senderDocument = await _firebaseFirestore
            .collection('users')
            .where(
              'id',
              isEqualTo: senderIdOrEmail,
            )
            .get();
      }

      // start conversation if recipient data is found
      if (userDocument.docs.isNotEmpty && senderDocument.docs.isNotEmpty) {
        final recipient = userDocument.docs.first.data();
        final sender = senderDocument.docs.first.data();

        final conversationDocument =
            _firebaseFirestore.collection('conversations').doc();

        final docId = conversationDocument.id;

        final recipientUser = ChatUser.fromMap(recipient);
        final senderUser = ChatUser.fromMap(sender);

        final conversation = Conversation(
          participants: [recipientUser, senderUser],
          initiatedBy: senderUser.id,
          initiatedAt: DateTime.now(),
          lastUpdatedAt: DateTime.now(),
          documentId: docId,
          participantsIds: [recipientUser.id ?? "", senderUser.id ?? ""],
        );

        await conversationDocument.set(conversation.toMap());

        return conversation;
      } else {
        throw Exception('User not found!');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendMessage({
    required Message message,
    required String id,
  }) async {
    try {
      // generate unique docId for the shared conversation
      final docId = id;

      // recipient and sender conversation document
      final conversationDocument =
          _firebaseFirestore.collection('conversations').doc(docId);

      // recipient and sender messages collection
      final messageCollection = conversationDocument.collection('messages');

      final messageAsMap = message.toMap()
        ..addAll({
          'timestamp': Timestamp.now().millisecondsSinceEpoch,
          'status': "pending",
        });

      // add new message
      final messageRef = await messageCollection.add(
        messageAsMap,
      );

      // update message now with status [sent]
      await messageRef.update(
        messageAsMap
          ..addAll({
            'status': "sent",
          }),
      );

      // update conversation lastUpdatedAt and lastMessage fields
      await conversationDocument.update({
        'lastUpdatedAt': Timestamp.now().millisecondsSinceEpoch,
        'lastMessage': messageAsMap,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<List<Message>> messageStream({
    required String id,
  }) =>
      _firebaseFirestore
          .collection('conversations')
          .doc(id)
          .collection('messages')
          .orderBy('timestamp')
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => Message.fromMap(doc.data()))
                .toList(),
          );

  Stream<List<Conversation>> conversationStream({required String userId}) =>
      _firebaseFirestore
          .collection('conversations')
          .where(
            'participantsIds',
            arrayContains: userId,
          )
          .orderBy('lastUpdatedAt', descending: true)
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs
                .map((doc) => Conversation.fromMap(doc.data()))
                .toList(),
          );
}
