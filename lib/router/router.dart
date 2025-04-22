import 'package:frontend_development/feature/load/load.dart';
import 'package:frontend_development/feature/login/login.dart';
import 'package:frontend_development/feature/registration/registration.dart';

final routes = {
  '/': (context) => const LoadScreen(),
  '/login': (context) => const LoginScreen(),
  '/registration_user': (context) => const RegistrationUserScreen(),
  '/registration_medical_card': (context) => const RegistrationMedicalCardScreen(),
};
