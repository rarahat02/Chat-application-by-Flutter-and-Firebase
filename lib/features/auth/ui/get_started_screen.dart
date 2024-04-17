import 'package:chat_app_firebase_riverpod/common/ui/ui_utils.dart';
import 'package:chat_app_firebase_riverpod/features/auth/ui/login_screen.dart';
import 'package:chat_app_firebase_riverpod/features/auth/ui/register_screen.dart';
import 'package:flutter/material.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

class GetStartedScreen extends StatelessWidget {
  static const routeName = '/get-started';

  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
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
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 10)),
                      child: const Text(
                        'Sign up with mail',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: textColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Existing account?',
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: textColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}