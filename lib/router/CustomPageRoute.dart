import 'package:flutter/material.dart';

import '../feature/chat/chat.dart';
import '../feature/load/load.dart';
import '../feature/login/login.dart';
import '../feature/medical_card/medical_card.dart';
import '../feature/medication_schedule/medication_schedule.dart';
import '../feature/password_recovery/password_recovery.dart';
import '../feature/registration/registration.dart';
import '../feature/settings/settings.dart';
import '../feature/un_auth/un_auth.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final String routeName;
  final Offset beginOffset;
  final Object? arguments;

  CustomPageRoute({
    required this.routeName,
    required this.beginOffset,
    this.arguments,
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) {
      return _getPage(routeName, arguments);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const end = Offset.zero;
      const curve = Curves.fastLinearToSlowEaseIn;
      var tween = Tween(begin: beginOffset, end: end)
          .chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );


  static Widget _getPage(String routeName, Object? arguments) {
    switch (routeName) {
      case '/':
        return const LoadScreen();
      case '/login':
        return const LoginScreen();
      case '/registration_user':
        return const RegistrationUserScreen();
      case '/registration_medical_card':
        final args = arguments as Map<String, String>;
        return RegistrationMedicalCardScreen(
          email: args['email']!,
          password: args['password']!,
        );
      case '/send_code':
        return const SendCodeScreen();
      case '/check_code':
        final args = arguments as Map<String, String>;
        return CheckCodeScreen(
          email: args['email']!
        );
      case '/new_password':
        final args = arguments as Map<String, String>;
        return NewPasswordScreen(
          email: args['email']!
        );
      case '/chat':
        return const ChatScreen();
      case '/medical_card':
        return const MedicalCardScreen();
      case '/edit_medical_card':
        return const EditMedicalCardScreen();
      case '/medication_schedule':
        return const MedicationScheduleScreen();
      case '/add_medication_schedule':
        return const AddMedicationScheduleScreen();
      case '/edit_medication_schedule':
        return const EditMedicationScheduleScreen();
      case '/settings':
        return const SettingsScreen();
      case '/change_password':
        return const ChangePasswordScreen();
      case '/un_auth_chat':
        return const UnAuthChatScreen();
      case '/un_auth_medical_card':
        return const UnAuthMedicalCardScreen();
      case '/un_auth_medication_schedule':
        return const UnAuthMedicationScheduleScreen();
      case '/un_auth_add_medication_schedule':
        return const UnAuthAddMedicationScheduleScreen();
      case '/un_auth_edit_medication_schedule':
        return const UnAuthEditMedicationScheduleScreen();
      case '/un_auth_settings':
        return const UnAuthSettingsScreen();
      default:
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: Container(
              height: 110,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0, 1.5),
                  end: Alignment(0, -1),
                  colors: [Color(0xFF363E51), Color(0xFF181C24)],
                ),
                shape: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.white10,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Text(
              'Unknown route',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }
}
