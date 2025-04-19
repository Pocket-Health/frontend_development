import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  _LoadScreenState createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _startRotationLoop();
  }

  void _startRotationLoop() async {
    while (mounted) {
      await _controller.forward();
      await Future.delayed(const Duration(seconds: 2));
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
            child: AnimatedBuilder(
              animation: _rotation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotation.value,
                  child: child,
                );
              },
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
          ),
        ],
      ),
    );
  }
}