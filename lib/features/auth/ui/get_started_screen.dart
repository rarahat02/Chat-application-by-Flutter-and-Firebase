import 'package:chat_app_firebase_riverpod/common/widgets/responsive_center.dart';
import 'package:chat_app_firebase_riverpod/constants/app_sizes.dart';
import 'package:chat_app_firebase_riverpod/constants/breakpoints.dart';
import 'package:chat_app_firebase_riverpod/constants/colors.dart';
import 'package:chat_app_firebase_riverpod/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ResponsiveCenter(
          maxContentWidth: Breakpoint.tablet,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
          child: Card(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      context.pushNamed(AppRoute.register.name);
                      // try {
                      //   aMethodThatMightFail();
                      // } catch (exception, stackTrace) {
                      //   await Sentry.captureException(
                      //     exception,
                      //     stackTrace: stackTrace,
                      //   );
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor),
                    child: const Text(
                      'Sign up with mail',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: textColor),
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.p16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Existing account?',
                        style: TextStyle(fontSize: Sizes.p16, color: textColor),
                      ),
                      gapW12,
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoute.login.name);
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor),
                        ),
                      ),
                    ],
                  ),
                  gapH20
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
