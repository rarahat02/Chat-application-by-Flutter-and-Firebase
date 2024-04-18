import 'package:chat_app_firebase_riverpod/constants/db_collections.dart';
import 'package:chat_app_firebase_riverpod/features/chat/data/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  ChatService(this._firebaseAuth, this._fireStore);

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final timeStamp = Timestamp.now();

    final newMessage = MessageModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timeStamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort ids (this make sure chatroom ids are same for any pair of users)
    String chatRoomId = ids.join("_");

    await _fireStore
        .collection(Db.chatRoom)
        .doc(chatRoomId)
        .collection(Db.message)
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    final charRoomId = ids.join("_");

    return _fireStore
        .collection(Db.chatRoom)
        .doc(charRoomId)
        .collection(Db.message)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}

final chatServiceProvider = Provider.autoDispose(
    (ref) => ChatService(FirebaseAuth.instance, FirebaseFirestore.instance));

final userCollectionProvider = StreamProvider.autoDispose(
    (ref) => FirebaseFirestore.instance.collection(Db.user).snapshots());

final currentUserProvider =
    Provider.autoDispose((ref) => FirebaseAuth.instance.currentUser);
