import 'package:chat_app_firebase_riverpod/common/widgets/responsive_center.dart';
import 'package:chat_app_firebase_riverpod/constants/app_sizes.dart';
import 'package:chat_app_firebase_riverpod/constants/breakpoints.dart';
import 'package:chat_app_firebase_riverpod/constants/colors.dart';
import 'package:chat_app_firebase_riverpod/features/auth/ui/login_card.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
      body: const ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: LoginCard(),
      ),
    );
  }
}
