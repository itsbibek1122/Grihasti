import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

void mySnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(16),
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: AutoSizeText(
          text,
          style: TextStyle(fontSize: 15),
          maxLines: 3,
        ),
      ),
    ),
  );
}
