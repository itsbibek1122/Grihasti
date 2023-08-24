import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipientUserId =
        ModalRoute.of(context)!.settings.arguments as String;

    // Now you have the recipientUserId and can use it to set up the chat screen
    // and communicate with the specific user who posted the property.

    // Your chat screen implementation goes here.

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with User'), // You can customize the title
      ),
      body: Center(
        child: Text('Chat content goes here'), // Replace with your chat UI
      ),
    );
  }
}
