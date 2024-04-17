import 'package:chat_app_firebase_riverpod/common/ui/ui_utils.dart';
import 'package:chat_app_firebase_riverpod/features/auth/ui/register_card.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: backgroundColor,
        primary: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: const RegisterCard(),
      ),
    );
  }
}
