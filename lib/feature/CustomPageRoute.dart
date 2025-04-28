import 'package:flutter/material.dart';
import 'package:frontend_development/feature/medical_card/medical_card.dart';
import 'package:frontend_development/feature/password_recovery/password_recovery.dart';
import 'package:frontend_development/feature/registration/registration.dart';

import 'chat/chat.dart';
import 'load/load.dart';
import 'login/login.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final String routeName;
  final Offset beginOffset;

  CustomPageRoute({required this.routeName, required this.beginOffset})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) {
      return _getPage(routeName);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const end = Offset.zero;
      const curve = Curves.fastLinearToSlowEaseIn;

      var tween = Tween(begin: beginOffset, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );

  static Widget _getPage(String routeName) {
    switch (routeName) {
      case '/':
        return const LoadScreen();
      case '/login':
        return const LoginScreen();
      case '/registration_user':
        return const RegistrationUserScreen();
      case '/registration_medical_card':
        return const RegistrationMedicalCardScreen();
      case '/send_code':
        return const SendCodeScreen();
      case '/check_code':
        return const CheckCodeScreen();
      case '/new_password':
        return const NewPasswordScreen();
      case '/chat':
        return const ChatScreen();
      case '/medical_card':
        return const MedicalCardScreen();
    // case '/medication_schedule':
    //   return const MedicationScheduleScreen();
    // case '/settings':
    //   return const SettingsScreen();
      default:
        return const Scaffold(
          body: Center(
            child: Text('Unknown route'),
          ),
        );
    }
  }}