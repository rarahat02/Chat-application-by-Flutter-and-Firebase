import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_state.dart';
import 'package:chat_app_firebase_riverpod/providers/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  final Ref ref;

  AuthController({
    required this.ref,
  }) : super(const AuthStateInitial());

  void login(String email, String password) async {
    state = const AuthStateLoading();

    try {
      await ref
          .read(authServiceProvider)
          .signInWithEmailPassword(email, password);
      state = const AuthStateSuccess();
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  void signup(String name, String email, String password) async {
    state = const AuthStateLoading();

    try {
      await ref
          .read(authServiceProvider)
          .signupWithEmailPassword(name, email, password);
      state = const AuthStateSuccess();
    } catch (e) {
      state = AuthStateError(e.toString());
    }
  }

  void signOut() async {
    await ref.read(authServiceProvider).signOutUser();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
    (ref) => AuthController(ref: ref));
