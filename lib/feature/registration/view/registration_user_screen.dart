import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/repository/registration_repository.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

class RegistrationUserScreen extends StatefulWidget {
  const RegistrationUserScreen({super.key});

  @override
  State<RegistrationUserScreen> createState() => _RegistrationUserScreenState();
}

class _RegistrationUserScreenState extends State<RegistrationUserScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('open_registration_user_screen');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _registration() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Введите email и пароль',
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

    AppMetrica.reportEvent('check_email_for_registration');

    final registrationRepository = RegistrationRepository();
    int responseCode = await registrationRepository.checkEmail(email: email, password: password);

    if (responseCode == 200) {
      AppMetrica.reportEvent('email_available_for_registration');
      Navigator.push(
        context,
        CustomPageRoute(
          routeName: '/registration_medical_card',
          beginOffset: Offset(1.0, 0.0),
          arguments: {
            'email': email,
            'password': password,
          },
        ),
      );
    } else if (responseCode == 409) {
      AppMetrica.reportError(message: 'error_registration: $responseCode email already registered');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Данная почта уже зарегистрирована',
            style: TextStyle(color: Colors.black),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    } else {
      AppMetrica.reportError(message: 'error_registration: $responseCode');
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
                top: screenSize.height / 10,
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/registration/registration_screen.svg',
                  width: screenSize.width,
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
                                  'Регистрация',
                                  style: TextTheme.of(context).titleMedium,
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
                                    onPressed: _registration,
                                    child: Text(
                                      'Продолжить',
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
