import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

import '../../../repository/repository.dart';

class SendCodeScreen extends StatefulWidget {
  const SendCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SendCodeScreen();
  }
}

class _SendCodeScreen extends State<SendCodeScreen> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendCode() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Введите email',
            style: TextStyle(color: Colors.black),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    AppMetrica.reportEvent('send_code');

    final passwordRecoveryRepository = PasswordRecoveryRepository();
    int responseCode = await passwordRecoveryRepository.sendCode(email: email);

    if (responseCode == 200) {
      AppMetrica.reportEvent('success_send_code');
      Navigator.push(
        context,
        CustomPageRoute(routeName: '/check_code', beginOffset: Offset(1.0, 0.0), arguments: {'email': email}),
      );
    }else if (responseCode == 403) {
      AppMetrica.reportEvent('error_send_code: $responseCode user not found');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Пользователь не найден',
            style: TextStyle(color: Colors.black),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      AppMetrica.reportEvent('error_send_code: $responseCode');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Неизвестная ошибка',
            style: TextStyle(color: Colors.black),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('open_send_code_screen');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final spacing = 25.0;
    final inputFieldWidth = screenSize.width * 0.63;
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  'assets/images/password_recovery/password_recovery_screen.svg',
                  width: screenSize.width * 0.87,
                ),
              ),
              Center(
                child: SizedBox(
                  width: screenSize.width * 0.75,
                  child: IntrinsicHeight(
                    child: Container(
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
                        children: [
                          InnerShadow(
                            shadows: [
                              Shadow(
                                color: Color(0xFF191E29),
                                blurRadius: 30,
                                offset: Offset(4, 10),
                              ),
                            ],
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF353F54),
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: spacing / 2),
                                Text(
                                  'Восстановление пароля',
                                  style: TextTheme.of(context).titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: spacing / 2),
                                Container(
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
                                              borderRadius:
                                              BorderRadius.circular(12),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextField(
                                        controller: _emailController,
                                        textAlign: TextAlign.center,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Почта',
                                          hintStyle:
                                          TextTheme.of(context).labelMedium,
                                        ),
                                        style: TextTheme.of(context).labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spacing),
                                Container(
                                  width: inputFieldWidth,
                                  height: inputFieldWidth / 4.5,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(-0.05, -1.5),
                                      end: Alignment(0.05, 2.5),
                                      colors: [
                                        Color(0xFF34C8E8),
                                        Color(0xFF4E4AF2),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x7F2A3345),
                                        blurRadius: 10,
                                        offset: Offset(0, -5),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: Color(0xFF10141B),
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: TextButton(
                                    onPressed: sendCode,
                                    child: Text(
                                      'Отправить код',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            offset: Offset(0, 0),
                                            blurRadius: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spacing / 2),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CustomPageRoute(
                                        routeName: '/login',
                                        beginOffset: Offset(-1.0, 0.0),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Войти',
                                    style: TextTheme.of(context).titleSmall,
                                  ),
                                ),
                                SizedBox(height: spacing / 2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
