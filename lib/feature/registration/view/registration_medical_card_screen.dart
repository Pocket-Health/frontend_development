import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationMedicalCardScreen extends StatefulWidget {
  const RegistrationMedicalCardScreen({super.key});

  @override
  State<RegistrationMedicalCardScreen> createState() =>
      _RegistrationMedicalCardScreenState();
}

class _RegistrationMedicalCardScreenState
    extends State<RegistrationMedicalCardScreen> {
  bool passwordVisible = true;

  final List<String> _bloodTypes = [
    'I+',
    'I-',
    'II+',
    'II-',
    'III+',
    'III-',
    'IV+',
    'IV-',
  ];
  String? _selectedBloodType;

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
                            _selectedBloodType = type;
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
                                        GestureDetector(
                                          onTap:
                                              () =>
                                                  _showBloodTypeDialog(context),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: inputFieldWidth,
                                            height: inputFieldWidth / 4.5,
                                            child: Text(
                                              _selectedBloodType ??
                                                  'Группа крови',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.labelMedium,
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
                                        TextField(
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
                                      onPressed: () {},
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
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pushNamed('/registration_user');
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
              ),
            ],
          );
        },
      ),
    );
  }
}
