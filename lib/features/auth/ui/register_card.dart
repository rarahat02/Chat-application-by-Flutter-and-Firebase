import 'package:chat_app_firebase_riverpod/constants/colors.dart';
import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_controller.dart';
import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterCard extends HookConsumerWidget {
  const RegisterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final nameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final confirmPasswordFocusNode = useFocusNode();

    final formKey = useMemoized(() => GlobalKey<FormState>(), []);

    void performSignup(String name, String email, String password) {
      ref.read(authControllerProvider.notifier).signup(name, email, password);
    }

    final handleSubmit = useCallback(() {
      if (formKey.currentState?.validate() ?? false) {
        performSignup(
          nameController.text,
          emailController.text,
          passwordController.text,
        );
      }
    }, [nameController, emailController, passwordController]);

    ref.listen<AuthState>(authControllerProvider, (_, next) {
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            labelText: 'Your name',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.green),
                            hintText: 'Enter your Name'),
                        focusNode: nameFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(emailFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            labelText: 'Your Email',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.green),
                            hintText: 'Enter your Email'),
                        focusNode: emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Please Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.green),
                            hintText: 'Enter your Password'),
                        obscureText: true,
                        focusNode: passwordFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(confirmPasswordFocusNode);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a valid password';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.green),
                            hintText: 'Confirm Password'),
                        obscureText: true,
                        focusNode: confirmPasswordFocusNode,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          handleSubmit();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a valid password';
                          }
                          if (value != passwordController.text) {
                            return 'Invalid Password, Please check again';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                            ),
                            onPressed: () => handleSubmit(),
                            child: const Text(
                              'Create an account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
