import 'package:chat_app_firebase_riverpod/constants/app_sizes.dart';
import 'package:chat_app_firebase_riverpod/features/notification/service/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsCard extends ConsumerWidget {
  const NotificationsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomIds = ref.watch(userChatRoomIdsProvider);

    return chatRoomIds.when(
      data: (chatRooms) {
        for (var chatRoomId in chatRooms) {
          ref.listen<AsyncValue<DocumentChange>>(
              messagesInChatRoomProvider(chatRoomId), (previous, change) {
            change.whenData((documentChange) {
              return Text(
                  'New message in $chatRoomId: ${documentChange.doc.data()}');
            });
          });
        }
        return const Scaffold(
          body: Center(
            child: Text(
              'No New Notifications!',
              style: TextStyle(fontSize: Sizes.p24),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
