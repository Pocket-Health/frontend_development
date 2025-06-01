import 'package:app_links/app_links.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

import '../../../repository/repository.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  final AppLinks _appLinks = AppLinks();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  void hasToken() async {
    final accessToken = await secureStorage.read(key: 'accessToken');
    final refreshToken = await secureStorage.read(key: 'refreshToken');
    if (accessToken != null && refreshToken != null) {
      await LoginRepository().refresh();
      Navigator.push(
        context,
        CustomPageRoute(
          routeName: '/chat',
          beginOffset: Offset(0.0, 0.0),
        ),
      );
    } else {
      Navigator.push(
        context,
        CustomPageRoute(
          routeName: '/login',
          beginOffset: Offset(0.0, 0.0),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _handleInitialUri();
  }

  void _handleInitialUri() async {
    try {
      final uri = await _appLinks.getInitialLink();
      final screen = uri?.queryParameters['screen'];
      if (screen == 'medical_card') {
        AppMetrica.reportEvent('used_sos_widget');
        final accessToken = await secureStorage.read(key: 'accessToken');
        final refreshToken = await secureStorage.read(key: 'refreshToken');
        if (accessToken != null && refreshToken != null) {
          await LoginRepository().refresh();
          Navigator.push(
            context,
            CustomPageRoute(
              routeName: '/medical_card',
              beginOffset: Offset(0.0, 0.0),
            ),
          );
          return;
        } else {
          hasToken();
        }
      }
    } catch (e) {
      return;
    }
    hasToken();
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
                  'assets/images/load/load_screen_up.svg',
                  width: screenSize.width,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  'assets/images/load/load_screen_down.svg',
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