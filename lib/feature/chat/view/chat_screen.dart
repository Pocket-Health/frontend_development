import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final inputFieldWidth = screenSize.width * 0.9;
    final iconHeight = 80.0;
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  'assets/images/chat/chat_screen.svg',
                  width: screenSize.width * 0.9,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Center(
                  child: SizedBox(
                    width: screenSize.width,
                    child: IntrinsicHeight(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF353F54),
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 10,
                                ),
                                width: inputFieldWidth,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: InnerShadow(
                                          shadows: [
                                            Shadow(
                                              color: Color(0xFF191E29),
                                              blurRadius: 5,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth: inputFieldWidth,
                                              maxWidth: inputFieldWidth,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: inputFieldWidth,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Введите ваш вопрос',
                                          hintStyle:
                                              Theme.of(
                                                context,
                                              ).textTheme.labelMedium,
                                        ),
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.labelSmall,
                                      ),
                                    ),
                                  ],
                                ),
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
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/icons/active/active_search_icon.svg',
                    height: 67,
                  ),
                ),
              ),
              MaterialButton(
                height: iconHeight,
                onPressed: () {},
                child: Container(
                  child: SvgPicture.asset(
                    'assets/icons/inactive/inactive_medical_card_icon.svg',
                    height: 22,
                  ),
                ),
              ),
              MaterialButton(
                height: iconHeight,
                onPressed: () {},
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
