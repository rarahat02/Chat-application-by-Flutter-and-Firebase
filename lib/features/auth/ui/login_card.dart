import 'package:chat_app_firebase_riverpod/constants/app_sizes.dart';
import 'package:chat_app_firebase_riverpod/constants/colors.dart';
import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_controller.dart';
import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginCard extends HookConsumerWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    void performLogin(String email, String password) {
      ref.read(authControllerProvider.notifier).login(email, password);
    }

    final handleSubmit = useCallback(() {
      if (formKey.currentState?.validate() ?? false) {
        performLogin(emailController.text, passwordController.text);
      }
    }, [emailController, passwordController]);

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next is AuthStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.error)));
      } else if (next is AuthStateSuccess) {
        Navigator.of(context).pop();
      }
    });

    return SingleChildScrollView(
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                      labelText: 'Your Email',
                      labelStyle: TextStyle(fontSize: 16, color: Colors.green),
                      hintText: 'Enter your Email'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
                  validator: (value) => (value == null || !value.contains('@'))
                      ? 'Please enter a valid email'
                      : null,
                ),
                TextFormField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle:
                          TextStyle(fontSize: Sizes.p16, color: Colors.green),
                      hintText: 'Enter your Password'),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => handleSubmit(),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter a valid password'
                      : null,
                ),
                gapH48,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100, // Example color
                    ),
                    onPressed: handleSubmit,
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          fontSize: Sizes.p16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black), // Example text style
                    ),
                  ),
                ),
                gapH12,
                const Text(
                  'Forgot password?',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: Sizes.p16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
