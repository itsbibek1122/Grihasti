import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Send a message to Firestore
void sendMessage(String message) {
  FirebaseFirestore.instance.collection('messages').add({
    'text': message,
    'timestamp': FieldValue.serverTimestamp(),
    // Add sender's ID or name
  });
}

// Retrieve messages from Firestore
Widget buildMessages() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp')
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return CircularProgressIndicator();
      }

      var messages = snapshot.data!.docs;

      List<Widget> messageWidgets = [];
      for (var message in messages) {
        var messageText = message['text'];
        // Add logic to format and display messages
        messageWidgets.add(
          ListTile(
            title: Text(messageText),
          ),
        );
      }

      return ListView(
        children: messageWidgets,
      );
    },
  );
}
