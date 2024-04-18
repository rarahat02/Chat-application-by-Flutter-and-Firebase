import 'package:chat_app_firebase_riverpod/common/widgets/responsive_center.dart';
import 'package:chat_app_firebase_riverpod/constants/breakpoints.dart';
import 'package:chat_app_firebase_riverpod/features/chat/controller/chat_controller.dart';
import 'package:chat_app_firebase_riverpod/features/chat/service/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatViewScreen extends HookConsumerWidget {
  final String userId;
  final String userName;
  final String userEmail;

  const ChatViewScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = useTextEditingController();
    final isShowSend = useState(false);

    final currentUser = ref.read(currentUserProvider);

    final chatService =
        ref.watch(chatServiceProvider).getMessages(currentUser!.uid, userId);

    final sendMessage = useCallback(() {
      if (messageController.text.isEmpty) {
        return;
      }
      ref
          .read(chatControllerProvider.notifier)
          .sendMessage(userId, messageController.text);
      messageController.clear();
    }, [messageController, userId]);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(userName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          subtitle: Text(userEmail),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
        ],
      ),
      body: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Column(
          children: [
            StreamBuilder(
              stream: chatService,
              builder: (context, snapshot) {
                Widget children;
                if (snapshot.hasError) {
                  children = const SizedBox(
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final messageData = snapshot.data!.docs;
                  children = Expanded(
                    child: ListView.builder(
                      itemCount: messageData.length,
                      itemBuilder: (context, index) {
                        final data = messageData
                            .map((e) => e.data() as Map<String, dynamic>)
                            .toList();
                        String message = data[index]['message'];
                        String senderId = data[index]['senderId'];
                        final alignment = currentUser.uid == senderId
                            ? Alignment.centerRight
                            : Alignment.centerLeft;

                        final color = currentUser.uid == senderId
                            ? Colors.green
                            : Colors.grey;
                        return Row(
                          children: [
                            alignment == Alignment.centerRight
                                ? const Spacer()
                                : const SizedBox(),
                            Container(
                              alignment: alignment,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  message,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            alignment == Alignment.centerLeft
                                ? const Spacer()
                                : const SizedBox()
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  children = const Expanded(
                    child: SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                return children;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.attach_file)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: messageController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: 'Write your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.file_copy),
                        ),
                      ),
                      onChanged: (value) {
                        isShowSend.value = value.isNotEmpty;
                      },
                    ),
                  ),
                ),
                !isShowSend.value
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.camera)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.mic)),
                        ],
                      )
                    : IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
