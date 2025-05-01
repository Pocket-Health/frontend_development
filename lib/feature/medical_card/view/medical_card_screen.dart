import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

class MedicalCardScreen extends StatefulWidget {
  const MedicalCardScreen({super.key});

  @override
  State<MedicalCardScreen> createState() => _MedicalCardScreenState();
}

class _MedicalCardScreenState extends State<MedicalCardScreen> {
  final TextEditingController _fullnameController = TextEditingController(
    text: 'Иванов Иван Иванович',
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final inputFieldWidth = screenSize.width;
    final iconHeight = 80.0;
    final spacing = 15.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 51,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          width: screenSize.width,
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
          child: Container(
            padding: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  height: iconHeight,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        routeName: '/edit_medical_card',
                        beginOffset: Offset(1.0, 0.0),
                      ),
                    );
                  },
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/icons/edit_medical_card.svg',
                      height: 27,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/medical_card/medical_card_screen.svg',
              width: screenSize.width * 0.67,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: spacing),
                      width: screenSize.width * 0.87,
                      child: IntrinsicHeight(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF353F54),
                            border: Border.all(
                              width: 1,
                              color: Colors.white10,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF2C3648),
                                blurRadius: 10,
                                offset: Offset(-4, -4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                  bottom: 12,
                                  left: 12,
                                  right: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        'ФИО',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 33,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
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
                                                height: inputFieldWidth / 7,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextField(
                                            controller: _fullnameController,
                                            textAlign: TextAlign.center,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            style:
                                                TextTheme.of(
                                                  context,
                                                ).bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
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
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: screenSize.width,
        height: 110,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1.5),
            colors: [Color(0xFF363E51), Color(0xFF181C24)],
          ),
          shape: Border(
            top: BorderSide(
              width: 1,
              color: Colors.white10,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                height: iconHeight,
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      routeName: '/chat',
                      beginOffset: Offset(-1.0, 0.0),
                    ),
                  );
                },
                child: Container(
                  child: SvgPicture.asset(
                    'assets/icons/inactive/inactive_search_icon.svg',
                    height: 22,
                  ),
                ),
              ),
              MaterialButton(
                height: iconHeight,
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/icons/active/active_medical_card_icon.svg',
                    height: 67,
                  ),
                ),
              ),
              MaterialButton(
                height: iconHeight,
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      routeName: '/medication_schedule',
                      beginOffset: Offset(1.0, 0.0),
                    ),
                  );
                },
                child: Container(
                  child: SvgPicture.asset(
                    'assets/icons/inactive/inactive_pill_icon.svg',
                    height: 22,
                  ),
                ),
              ),
              MaterialButton(
                height: iconHeight,
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      routeName: '/settings',
                      beginOffset: Offset(1.0, 0.0),
                    ),
                  );
                },
                child: Container(
                  child: SvgPicture.asset(
                    'assets/icons/inactive/inactive_settings_icon.svg',
                    height: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
