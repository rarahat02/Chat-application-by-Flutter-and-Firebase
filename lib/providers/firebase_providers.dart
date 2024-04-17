import 'package:chat_app_firebase_riverpod/features/auth/service/auth_service.dart';
import 'package:chat_app_firebase_riverpod/features/chat/service/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider.autoDispose<AuthService>(
    (ref) => AuthService(FirebaseAuth.instance, FirebaseFirestore.instance));

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authServiceProvider).authStateChange);

final firestoreStateProvider = StreamProvider.autoDispose(
    (ref) => FirebaseFirestore.instance.collection('USER').snapshots());

final authInstanceProvider =
    Provider.autoDispose((ref) => FirebaseAuth.instance.currentUser);

final chatServiceProvider = Provider.autoDispose(
    (ref) => ChatService(FirebaseAuth.instance, FirebaseFirestore.instance));
