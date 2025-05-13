import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

class UnAuthSettingsScreen extends StatefulWidget {
  const UnAuthSettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UnAuthSettingsScreenState();
}

class _UnAuthSettingsScreenState extends State<UnAuthSettingsScreen> {
  bool toggleOn = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final inputFieldWidth = screenSize.width;
    final iconHeight = 80.0;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              child: SvgPicture.asset(
                'assets/images/settings/settings_screen.svg',
                width: screenSize.width * 0.835,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 100),
                    Center(
                      child: SizedBox(
                        width: inputFieldWidth,
                        height: inputFieldWidth / 6,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: InnerShadow(
                            shadows: [
                              Shadow(
                                color: Color(0xFF2C3648),
                                blurRadius: 10,
                                offset: Offset(-4, -4),
                              ),
                            ],
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFF353F54),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white10,
                                  strokeAlign: BorderSide.strokeAlignInside,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    toggleOn = !toggleOn;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Уведомления',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
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
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: SvgPicture.asset(
                                        toggleOn
                                            ? 'assets/icons/toggle_on.svg'
                                            : 'assets/icons/toggle_off.svg',
                                        height: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: screenSize.width,
                  height: screenSize.width / 7,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            routeName: '/login',
                            beginOffset: Offset(1.0, 0.0),
                          ),
                        );
                      },
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
                ),
              ),
            ),
          ],
        ),
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
                      routeName: '/un_auth_chat',
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
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      routeName: '/un_auth_medical_card',
                      beginOffset: Offset(-1.0, 0.0),
                    ),
                  );
                },
                child: Container(
                  child: SvgPicture.asset(
                    'assets/icons/inactive/inactive_medical_card_icon.svg',
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
                      routeName: '/un_auth_medication_schedule',
                      beginOffset: Offset(-1.0, 0.0),
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
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/icons/active/active_settings_icon.svg',
                    height: 67,
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
