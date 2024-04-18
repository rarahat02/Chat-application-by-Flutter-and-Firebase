import 'package:chat_app_firebase_riverpod/constants/colors.dart';
import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: backgroundColor,
      primary: true,
      centerTitle: true,
      actions: [
        PopupMenuButton(
          position: PopupMenuPosition.under,
          itemBuilder: (context) => [
            PopupMenuItem(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center,
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Signout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                ref.read(authControllerProvider.notifier).signOut();
                Navigator.of(context).pop();
              },
            ))
          ],
          child: const CircleAvatar(
            child: Icon(
              Icons.person,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
