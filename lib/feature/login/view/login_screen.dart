import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final spacing = 25.0;
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/login_screen.svg',
                  width: screenSize.width,
                ),
              ),
              Center(
                child: Container(
                  width: screenSize.width * 0.8,
                  child: IntrinsicHeight(
                    child: Container(
                      decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                            spreadRadius: 1.0,
                            blurRadius: 20.0,
                            color: Color(0xFF2C3648),
                            offset: Offset(-4, -4),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Color(0xFF353F54),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: spacing/2),
                            Text(
                              'Вход',
                              style: TextTheme.of(context).titleMedium,
                            ),
                            SizedBox(height: spacing/2),
                            SizedBox(
                              width: screenSize.width * 0.65,
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Почта',
                                  hintStyle: TextTheme.of(context).labelMedium,
                                ),
                                style: TextTheme.of(context).labelSmall,
                              ),
                            ),
                            SizedBox(height: spacing),
                            SizedBox(
                              width: screenSize.width * 0.65,
                              child: TextField(
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: passwordVisible,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Пароль',
                                  hintStyle: TextTheme.of(context).labelMedium,
                                  prefix: SizedBox(width: 40),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                style: TextTheme.of(context).labelSmall,
                              ),
                            ),
                            SizedBox(height: spacing/2),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Забыли пароль?',
                                style: TextTheme.of(context).titleSmall,
                              ),
                            ),
                            SizedBox(height: spacing/2),
                            Container(
                              width: screenSize.width * 0.65,
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
                                    color: Color(0xFF10141B),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Color(0x7F2A3345),
                                    blurRadius: 10,
                                    offset: Offset(0, -5),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Войти',
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
                            SizedBox(height: spacing/2),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Зарегистрироваться',
                                style: TextTheme.of(context).titleSmall,
                              ),
                            ),
                            SizedBox(height: spacing/2),
                          ],
                        ),
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
