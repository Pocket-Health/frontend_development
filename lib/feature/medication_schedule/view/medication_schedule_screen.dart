import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

class MedicationScheduleScreen extends StatefulWidget{
  const MedicationScheduleScreen({super.key});

  @override
  State<MedicationScheduleScreen> createState() => _MedicationScheduleScreenState();
}

class _MedicationScheduleScreenState extends State<MedicationScheduleScreen>{
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
                        routeName: '/add_medication_schedule',
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
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      routeName: '/medical_card',
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