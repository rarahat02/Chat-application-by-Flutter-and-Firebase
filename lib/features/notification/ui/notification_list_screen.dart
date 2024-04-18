import 'package:chat_app_firebase_riverpod/common/widgets/responsive_center.dart';
import 'package:chat_app_firebase_riverpod/constants/app_sizes.dart';
import 'package:chat_app_firebase_riverpod/features/notification/ui/notifications_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ResponsiveCenter(
        padding: EdgeInsets.all(Sizes.p16), child: NotificationsCard());
  }
}
