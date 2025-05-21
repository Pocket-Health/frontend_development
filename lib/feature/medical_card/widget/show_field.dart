import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

class ShowField extends StatelessWidget {
  final String title;
  final String text;

  const ShowField({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final inputFieldWidth = screenSize.width;
    final spacing = 15.0;
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: spacing),
        width: screenSize.width * 0.87,
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFF353F54),
              border: Border.all(
                width: 1,
                color: Colors.white10,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF2C3648),
                  blurRadius: 10,
                  offset: Offset(-4, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 12, left: 12, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
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
                                  height: inputFieldWidth / 7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              controller: TextEditingController(text: text),
                              textAlign: TextAlign.center,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: TextTheme.of(context).bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
