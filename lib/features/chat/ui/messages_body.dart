import 'package:chat_app_firebase_riverpod/providers/firebase_providers.dart';
import 'package:chat_app_firebase_riverpod/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MessagesBody extends ConsumerWidget {
  const MessagesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(firestoreStateProvider);
    final authUser = ref.watch(authInstanceProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: chatState.when(
        data: (data) {
          final dataList = data.docs;
          return ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              final data = dataList[index].data();
              if (authUser!.email != data['email']) {
                return GestureDetector(
                  onTap: () => context.pushNamed(chatRoute, pathParameters: {
                    'userId': data['uid']
                  }, extra: {
                    'userName': data['firstName'],
                    'userEmail': data['email']
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(data['email'].toString()),
                        style: ListTileStyle.list,
                      ),
                      const Divider(),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          );
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
        loading: () => const CircularProgressIndicator(),
      )),
    );
  }
}
