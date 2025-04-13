import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF242C3B),
        body: Builder(
          builder: (context) {
            final screenSize = MediaQuery.of(context).size;
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/images/load_screen_up.svg',
                    width: screenSize.width,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: SvgPicture.asset(
                    'assets/images/load_screen_down.svg',
                    width: screenSize.width-40,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "POCKET",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 75,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          height: 0.7,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset.zero,
                              blurRadius: 30,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "HEALTH",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 75,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              offset: Offset.zero,
                              blurRadius: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}