import 'package:chat_app_firebase_riverpod/features/chat/ui/chat_page.dart';
import 'package:chat_app_firebase_riverpod/providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesBody extends ConsumerWidget {
  const MessagesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(firebaseFirestoreStateProvier);
    final authUser = ref.watch(firebaseAuthInstanceProvider);

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
                  onTap: () => Navigator.of(context)
                      .pushNamed(ChatPage.routeName, arguments: {
                    'userName': data['firstName'],
                    'userEmail': data['email'],
                    'userId': data['uid'],
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
