import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';
import 'package:hive/hive.dart';

import '../../../model/model.dart';
import '../../../repository/repository.dart';
import '../widget/widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _questionController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('open_chat_screen');
    final box = Hive.box<ChatHistory>('chatHistoryBox');
    messages = box.get('chatHistory')?.messages.reversed.toList() ?? [];
  }

  void sendQuestion() async {
    String question = _questionController.text;
    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Введите вопрос',
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

    AppMetrica.reportEvent('send_question');

    setState(() {
      messages.insert(0, {
        'message': {'text': question},
        'message2': {'text': 'Ожидайте ответа...'},
      });
      _questionController.clear();
    });

    final responseCode = await ChatRepository().sendQuestion(
      question: question,
    );

    final box = Hive.box<ChatHistory>('chatHistoryBox');

    if (responseCode == 200) {
      AppMetrica.reportEvent('get_answer');
      final updatedMessages = box.get('chatHistory')?.messages ?? [];
      setState(() {
        messages = updatedMessages.reversed.toList();
      });
    } else {
      AppMetrica.reportError(message: 'error_get_answer: $responseCode');
      setState(() {
        messages[0]['message2']['text'] = 'Ошибка при получении ответа';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final inputFieldWidth = screenSize.width * 0.9;
    final iconHeight = 80.0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          width: screenSize.width,
          height: 130,
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
            child: Text(
              textAlign: TextAlign.center,
              'Ответы сгенерированны ИИ.\n'
                  'Рекомендуем обратиться к специалисту.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
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
              top: 0,
              bottom: 95,
              width: screenSize.width,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final item = messages[index];
                        final question = item['message']?['text'] ?? '';
                        final answer = item['message2']?['text'] ?? '';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: ChatBubble(
                                text: question,
                                color: Color(0xFF37B6E9),
                              ),
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ChatBubble(
                                text: answer.toString().replaceAll('\\n', ''),
                                color: Color(0xFF4E4AF2),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ],
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
                                            borderRadius: BorderRadius.circular(
                                              17,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: inputFieldWidth,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxHeight: inputFieldWidth / 2,
                                            ),
                                            child: TextField(
                                              controller: _questionController,
                                              textAlign: TextAlign.left,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              minLines: 1,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'Введите симптомы',
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
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.send,
                                            color: Color(0xFF353F54),
                                          ),
                                          onPressed: () {
                                            sendQuestion();
                                          },
                                        ),
                                      ],
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
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      routeName: '/medical_card',
                      beginOffset: Offset(1.0, 0.0),
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
