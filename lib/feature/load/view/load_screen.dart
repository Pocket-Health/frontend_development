import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Builder(
        builder: (context) {
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
                  width: screenSize.width - 40,
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
    );
  }
}