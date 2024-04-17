import 'package:chat_app_firebase_riverpod/features/auth/controller/auth_service.dart';
import 'package:chat_app_firebase_riverpod/features/chat/controller/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthServiceProvider = Provider.autoDispose<AuthService>(
    (ref) => AuthService(FirebaseAuth.instance, FirebaseFirestore.instance));

final firebaseAuthStateProvider = StreamProvider.autoDispose<User?>(
    (ref) => ref.read(firebaseAuthServiceProvider).authStateChange);

final firebaseFirestoreStateProvier = StreamProvider.autoDispose(
    (ref) => FirebaseFirestore.instance.collection('USER').snapshots());

final firebaseAuthInstanceProvider =
    Provider.autoDispose((ref) => FirebaseAuth.instance.currentUser);

final firebaseChatServiceProvider = Provider.autoDispose(
    (ref) => ChatService(FirebaseAuth.instance, FirebaseFirestore.instance));
