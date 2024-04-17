import 'package:chat_app_firebase_riverpod/common/ui/ui_utils.dart';
import 'package:flutter/material.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: const Center(
        child: Text('No Notifications!'),
      ),
    );
  }
}
