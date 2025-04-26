import 'package:frontend_development/feature/load/load.dart';
import 'package:frontend_development/feature/login/login.dart';
import 'package:frontend_development/feature/registration/registration.dart';
import 'package:frontend_development/feature/password_recovery/password_recovery.dart';
import 'package:frontend_development/feature/chat/chat.dart';

final routes = {
  '/': (context) => const LoadScreen(),
  '/login': (context) => const LoginScreen(),
  '/registration_user': (context) => const RegistrationUserScreen(),
  '/registration_medical_card': (context) => const RegistrationMedicalCardScreen(),
  '/send_code': (context) => const SendCodeScreen(),
  '/check_code': (context) => const CheckCodeScreen(),
  '/new_password': (context) => const NewPasswordScreen(),
  '/chat': (context) => const ChatScreen(),
};
