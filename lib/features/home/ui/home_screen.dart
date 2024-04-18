import 'package:chat_app_firebase_riverpod/constants/colors.dart';
import 'package:chat_app_firebase_riverpod/features/chat/ui/chat_list/chat_list_screen.dart';
import 'package:chat_app_firebase_riverpod/features/home/ui/custom_bottom_navigation_bar.dart';
import 'package:chat_app_firebase_riverpod/features/notification/ui/notification_list_screen.dart';
import 'package:flutter/material.dart';

import 'custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  final List _screenBody = const [
    ChatListScreen(),
    NotificationListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        callback: (value) => setState(() {
          pageIndex = value;
        }),
      ),
      body: _screenBody[pageIndex],
    );
  }
}
