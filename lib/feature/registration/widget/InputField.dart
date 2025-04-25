import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

class InputField extends StatelessWidget {
  final String text;
  final TextInputType textInputType;

  InputField(this.text, this.textInputType);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final inputFieldWidth = screenSize.width * 0.63;
    return Container(
      width: inputFieldWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2C3648),
            blurRadius: 10,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: InnerShadow(
              shadows: [
                Shadow(
                  color: Color(0xFF191E29),
                  blurRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
              child: Container(
                width: inputFieldWidth,
                height: inputFieldWidth / 4.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            keyboardType: textInputType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: TextTheme.of(context).labelMedium,
            ),
            style: TextTheme.of(context).labelSmall,
          ),
        ],
      ),
    );
  }
}
