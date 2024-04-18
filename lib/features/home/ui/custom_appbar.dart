import 'package:chat_app_firebase_riverpod/constants/app_sizes.dart';
import 'package:chat_app_firebase_riverpod/constants/colors.dart';
import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_controller.dart';
import 'package:chat_app_firebase_riverpod/features/chat/service/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserState = ref.watch(currentUserProvider);

    return AppBar(
      backgroundColor: backgroundColor,
      primary: true,
      centerTitle: true,
      actions: [
        PopupMenuButton(
          position: PopupMenuPosition.under,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text(
                currentUserState.email ?? 'Not available',
                style: const TextStyle(color: textColor, fontSize: Sizes.p20),
              ),
            ),
            PopupMenuItem(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                ref.read(authControllerProvider.notifier).signOut();
                Navigator.of(context).pop();
              },
            ))
          ],
          child: CircleAvatar(
            child: Text(
              currentUserState!.email?.substring(0, 1).toUpperCase() ?? 'N/A',
              style: const TextStyle(color: textColor, fontSize: Sizes.p20),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
