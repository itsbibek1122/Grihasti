import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  final IconData iconData;
  final int value;
  final Color color;

  const CustomIndicator({
    Key? key,
    required this.iconData,
    required this.value,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: color,
          size: 32,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            value.toString(),
            style: TextStyle(color: color),
          ),
        )
      ],
    );
  }
}
