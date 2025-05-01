import 'package:flutter/material.dart';
import 'package:frontend_development/feature/medical_card/medical_card.dart';
import 'package:frontend_development/feature/password_recovery/password_recovery.dart';
import 'package:frontend_development/feature/registration/registration.dart';

import '../feature/chat/chat.dart';
import '../feature/load/load.dart';
import '../feature/login/login.dart';
import '../feature/medication_schedule/medication_schedule.dart';

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

          var tween = Tween(
            begin: beginOffset,
            end: end,
          ).chain(CurveTween(curve: curve));
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
      case '/edit_medical_card':
        return const EditMedicalCardScreen();
      case '/medication_schedule':
        return const MedicationScheduleScreen();
      case '/add_medication_schedule':
        return const AddMedicationScheduleScreen();
      // case '/edit_medication_schedule':
      //   return const EditMedicationScheduleScreen();
      // case '/delete_medication_schedule':
      //   return const DeleteMedicationScheduleScreen();
      // case '/settings':
      //   return const SettingsScreen();
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
