import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

import '../../../repository/repository.dart';

class RegistrationMedicalCardScreen extends StatefulWidget {
  final String email;
  final String password;

  const RegistrationMedicalCardScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<RegistrationMedicalCardScreen> createState() =>
      _RegistrationMedicalCardScreenState();
}

class _RegistrationMedicalCardScreenState
    extends State<RegistrationMedicalCardScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _diseasesController = TextEditingController();

  void _registration() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _fullNameController.text.isEmpty ||
        _heightController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _bloodTypeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Введите данные',
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

    final registrationRepository = RegistrationRepository();
    String bloodType;
    switch (_bloodTypeController.text) {
      case 'I Rh+':
        bloodType = '1+';
        break;
      case 'I Rh-':
        bloodType = '1-';
        break;
      case 'II Rh+':
        bloodType = '2+';
        break;
      case 'II Rh-':
        bloodType = '2-';
        break;
      case 'III Rh+':
        bloodType = '3+';
        break;
      case 'III Rh-':
        bloodType = '3-';
        break;
      case 'IV Rh+':
        bloodType = '4+';
        break;
      case 'IV Rh-':
        bloodType = '4-';
        break;
      default:
        bloodType = '';
    }

    int responseCode = await registrationRepository.registration(
      email: _emailController.text,
      password: _passwordController.text,
      fullName: _fullNameController.text,
      height: _heightController.text,
      weight: _weightController.text,
      bloodType: bloodType,
      allergies: _allergiesController.text,
      diseases: _diseasesController.text,
    );

    if (responseCode == 201) {
      Navigator.push(
        context,
        CustomPageRoute(routeName: '/login', beginOffset: Offset(1.0, 0.0)),
      );
    } else {
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

  final List<String> _bloodTypes = [
    'I Rh+',
    'I Rh-',
    'II Rh+',
    'II Rh-',
    'III Rh+',
    'III Rh-',
    'IV Rh+',
    'IV Rh-',
  ];

  void _showBloodTypeDialog(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final inputFieldWidth = screenSize.width * 0.63;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: inputFieldWidth - 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.2,
                children:
                    _bloodTypes.map((type) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _bloodTypeController.text = type;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.05, -1.5),
                              end: Alignment(0.05, 2.5),
                              colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            type,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  offset: Offset(0, 0),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _passwordController.text = widget.password;
    _bloodTypeController.text = 'Группа крови';
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
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: spacing),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenSize.width * 0.75,
                    ),
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
                                    'Ваши данные',
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
                                          controller: _fullNameController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'ФИО',
                                            hintStyle:
                                                TextTheme.of(
                                                  context,
                                                ).labelMedium,
                                          ),
                                          style:
                                              TextTheme.of(context).labelSmall,
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
                                        TextField(
                                          controller: _heightController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Рост',
                                            hintStyle:
                                                TextTheme.of(
                                                  context,
                                                ).labelMedium,
                                          ),
                                          style:
                                              TextTheme.of(context).labelSmall,
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
                                        TextField(
                                          controller: _weightController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Вес',
                                            hintStyle:
                                                TextTheme.of(
                                                  context,
                                                ).labelMedium,
                                          ),
                                          style:
                                              TextTheme.of(context).labelSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: spacing),
                                  GestureDetector(
                                    onTap: () => _showBloodTypeDialog(context),
                                    child: Container(
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
                                          Container(
                                            alignment: Alignment.center,
                                            width: inputFieldWidth,
                                            height: inputFieldWidth / 4.5,
                                            child: Text(
                                              _bloodTypeController.text,
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.labelMedium,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                        TextField(
                                          controller: _allergiesController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Аллергии',
                                            hintStyle:
                                                TextTheme.of(
                                                  context,
                                                ).labelMedium,
                                          ),
                                          style:
                                              TextTheme.of(context).labelSmall,
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
                                        TextField(
                                          controller: _diseasesController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Заболевания',
                                            hintStyle:
                                                TextTheme.of(
                                                  context,
                                                ).labelMedium,
                                          ),
                                          style:
                                              TextTheme.of(context).labelSmall,
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
                                        'Регистрация',
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
                                    onPressed: _registration,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
