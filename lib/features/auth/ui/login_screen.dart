import 'package:chat_app_firebase_riverpod/common/ui/ui_utils.dart';
import 'package:chat_app_firebase_riverpod/features/auth/ui/login_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        primary: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: const LoginCard(),
      ),
    );
  }
}
