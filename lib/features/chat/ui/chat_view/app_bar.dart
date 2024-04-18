import 'package:flutter/material.dart';

PreferredSizeWidget getChatViewAppbar(String userName, String userEmail) =>
    AppBar(
      title: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(userName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(userEmail),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
      ],
    );
