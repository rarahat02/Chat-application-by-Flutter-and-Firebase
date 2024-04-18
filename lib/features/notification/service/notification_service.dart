import 'package:chat_app_firebase_riverpod/constants/db_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  NotificationService(this._firebaseAuth, this._fireStore);

  Stream<List<String>> getUserChatRoomIds() {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    return _fireStore
        .collection(Db.user)
        .doc(currentUserId)
        .collection(Db.chatRoom)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  Stream<DocumentChange> listenToMessagesInChatRoom(String chatRoomId) {
    return _fireStore
        .collection(Db.chatRoom)
        .doc(chatRoomId)
        .collection(Db.message)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .expand((snapshot) => snapshot.docChanges)
        .where((change) => change.type == DocumentChangeType.added);
  }
}

final notificationServiceProvider = Provider((ref) =>
    NotificationService(FirebaseAuth.instance, FirebaseFirestore.instance));

final userChatRoomIdsProvider = StreamProvider<List<String>>((ref) {
  final service = ref.watch(notificationServiceProvider);
  return service.getUserChatRoomIds();
});

final messagesInChatRoomProvider =
    StreamProvider.family<DocumentChange, String>((ref, chatRoomId) {
  final service = ref.watch(notificationServiceProvider);
  return service.listenToMessagesInChatRoom(chatRoomId);
});
