import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

import '../../../repository/repository.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;

  const NewPasswordScreen({super.key, required this.email});

  @override
  State<StatefulWidget> createState() {
    return _NewPasswordScreen();
  }
}

class _NewPasswordScreen extends State<NewPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = true;

  Future<void> passwordRecovery() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Введите пароль',
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

    AppMetrica.reportEvent('password_recovery');

    final passwordRecoveryRepository = PasswordRecoveryRepository();
    int responseCode = await passwordRecoveryRepository.passwordRecovery(
      email: email,
      password: password,
    );

    if (responseCode == 200) {
      AppMetrica.reportEvent('success_password_recovery');
      Navigator.push(
        context,
        CustomPageRoute(routeName: '/login', beginOffset: Offset(1.0, 0.0)),
      );
    } else if (responseCode == 403) {
      AppMetrica.reportEvent('error_password_recovery: $responseCode invalid_data');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Неверные данные',
            style: TextStyle(color: Colors.black),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      AppMetrica.reportError(message: 'error_password_recovery: $responseCode');
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
    }
  }

  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('open_new_password_screen');
    _emailController.text = widget.email;
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
                                  'Введите новый пароль',
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
                                      SizedBox(height: spacing),
                                      Center(
                                        child: SizedBox(
                                          width: inputFieldWidth,
                                          child: TextField(
                                            controller: _passwordController,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            textInputAction:
                                                TextInputAction.done,
                                            obscureText: passwordVisible,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Пароль',
                                              hintStyle:
                                                  TextTheme.of(
                                                    context,
                                                  ).labelMedium,
                                              prefix: SizedBox(
                                                width: inputFieldWidth / 5.45,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  passwordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    passwordVisible =
                                                        !passwordVisible;
                                                  });
                                                },
                                              ),
                                            ),
                                            style:
                                                TextTheme.of(
                                                  context,
                                                ).labelSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: spacing),
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
                                      Center(
                                        child: SizedBox(
                                          width: inputFieldWidth,
                                          child: TextField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            textInputAction:
                                                TextInputAction.done,
                                            obscureText: passwordVisible,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Повторите пароль',
                                              hintStyle:
                                                  TextTheme.of(
                                                    context,
                                                  ).labelMedium,
                                            ),
                                            style:
                                                TextTheme.of(
                                                  context,
                                                ).labelSmall,
                                          ),
                                        ),
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
                                    onPressed: passwordRecovery,
                                    child: Text(
                                      'Сменить пароль',
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
                                        routeName: '/check_code',
                                        beginOffset: Offset(-1.0, 0.0),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Вернуться назад',
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
