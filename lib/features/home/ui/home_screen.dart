import 'package:chat_app_firebase_riverpod/features/chat/ui/messages_body.dart';
import 'package:chat_app_firebase_riverpod/features/home/ui/custom_bottom_navigation_bar.dart';
import 'package:chat_app_firebase_riverpod/features/home/ui/customappbar.dart';
import 'package:chat_app_firebase_riverpod/features/notification/ui/notifications_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  final List _screenBody = const [
    MessagesBody(),
    NotificationsBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(
        callback: (value) => setState(() {
          pageIndex = value;
        }),
      ),
      body: _screenBody[pageIndex],
    );

    // return const Scaffold(
    //   backgroundColor: Colors.black,
    //   appBar: CustomAppBar(),
    //   body: MessagesBody(),
    // );
  }
}
