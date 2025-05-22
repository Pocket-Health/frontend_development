import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final Color color;

  const ChatBubble({required this.text, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      child: InnerShadow(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              style: BorderStyle.solid,
              width: 5,
              color: color,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
    );
  }
}