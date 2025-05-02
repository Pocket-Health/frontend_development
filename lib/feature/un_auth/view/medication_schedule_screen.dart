import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

class UnAuthMedicationScheduleScreen extends StatefulWidget{
  const UnAuthMedicationScheduleScreen({super.key});

  @override
  State<UnAuthMedicationScheduleScreen> createState() => _UnAuthMedicationScheduleScreenState();
}

class _UnAuthMedicationScheduleScreenState extends State<UnAuthMedicationScheduleScreen>{
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
                        routeName: '/un_auth_add_medication_schedule',
                        beginOffset: Offset(1.0, 0.0),
                      ),
                    );
                  },
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/icons/add_medication_schedule.svg',
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
            left: 0,
            child: SvgPicture.asset(
              'assets/images/medication_schedule/medication_schedule.svg',
              width: screenSize.width,
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
                      child: Slidable(
                        key: ValueKey('med_schedule_card_1'),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          extentRatio: 0.7,
                          children: [
                            SizedBox(width: 40),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    routeName: '/un_auth_edit_medication_schedule',
                                    beginOffset: Offset(1.0, 0.0),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF353F54),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/edit_medication_schedule.svg',
                                    width: 87,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Вы уверены, что хотите удалить расписание?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 200),
                                                  height: 48,
                                                  decoration: ShapeDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment(-0.05, -1.5),
                                                      end: Alignment(0.05, 2.5),
                                                      colors: [
                                                        Colors.grey.shade300,
                                                        Colors.grey.shade400,
                                                      ],
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: Text(
                                                      'Отмена',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 200),
                                                  height: 48,
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
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // TODO: удалить запись
                                                    },
                                                    child: Text(
                                                      'Удалить',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        shadows: [
                                                          Shadow(
                                                            color: Colors.black26,
                                                            offset: Offset(0, 1),
                                                            blurRadius: 4,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF353F54),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/delete_medication_schedule.svg',
                                    width: 87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                blurRadius: 15,
                                offset: Offset(2, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Кардиомагнил',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 33,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, bottom: 7),
                                    child: Text(
                                      'Пн, Пт',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15, bottom: 7),
                                    child: Text(
                                      '10:00, 17:00',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: spacing),
                      width: screenSize.width * 0.87,
                      child: Slidable(
                        key: ValueKey('med_schedule_card_2'),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          extentRatio: 0.7,
                          children: [
                            SizedBox(width: 40),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    routeName: '/edit_medication_schedule',
                                    beginOffset: Offset(1.0, 0.0),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF353F54),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/edit_medication_schedule.svg',
                                    width: 87,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Вы уверены, что хотите удалить расписание?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 200),
                                                  height: 48,
                                                  decoration: ShapeDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment(-0.05, -1.5),
                                                      end: Alignment(0.05, 2.5),
                                                      colors: [
                                                        Colors.grey.shade300,
                                                        Colors.grey.shade400,
                                                      ],
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: Text(
                                                      'Отмена',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Expanded(
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 200),
                                                  height: 48,
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
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // TODO: удалить запись
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Удалить',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        shadows: [
                                                          Shadow(
                                                            color: Colors.black26,
                                                            offset: Offset(0, 1),
                                                            blurRadius: 4,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF353F54),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/delete_medication_schedule.svg',
                                    width: 87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                blurRadius: 15,
                                offset: Offset(2, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Иммудон',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 33,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, bottom: 7),
                                    child: Text(
                                      'Вт, Вс',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15, bottom: 7),
                                    child: Text(
                                      '12:00, 21:00',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/icons/active/active_pill_icon.svg',
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
                      routeName: '/un_auth_settings',
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