import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/feature/medical_card/widget/widget.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';
import 'package:hive/hive.dart';

import '../../../model/model.dart';

class MedicalCardScreen extends StatefulWidget {
  const MedicalCardScreen({super.key});

  @override
  State<MedicalCardScreen> createState() => _MedicalCardScreenState();
}

class _MedicalCardScreenState extends State<MedicalCardScreen> {
  String fullName = '';
  String height = '';
  String weight = '';
  String bloodType = '';
  String allergies = '';
  String diseases = '';

  @override
  void initState() {
    final box = Hive.box<MedicalCard>('medicalCardBox');
    final medicalCard = box.get('medicalCard');

    fullName = medicalCard?.fullName ?? '';
    height = medicalCard?.height.toString() ?? '';
    weight = medicalCard?.weight.toString() ?? '';
    bloodType = medicalCard?.bloodType ?? '';
    switch (bloodType) {
      case '1+':
        bloodType = 'I Rh+';
        break;
      case '1-':
        bloodType = 'I Rh-';
        break;
      case '2+':
        bloodType = 'II Rh+';
        break;
      case '2-':
        bloodType = 'II Rh-';
        break;
      case '3+':
        bloodType = 'III Rh+';
        break;
      case '3-':
        bloodType = 'III Rh-';
        break;
      case '4+':
        bloodType = 'IV Rh+';
        break;
      case '4-':
        bloodType = 'IV Rh-';
        break;
    }
    allergies = medicalCard?.allergies ?? '';
    diseases = medicalCard?.diseases ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                  ShowField(title: 'ФИО', text: fullName),
                  ShowField(title: 'Рост', text: '$height см'),
                  ShowField(title: 'Вес', text: '$weight кг'),
                  ShowField(title: 'Группа крови', text: bloodType),
                  ShowField(title: 'Аллергии', text: allergies == 'None' ? '' : allergies),
                  ShowField(title: 'Заболевания', text: diseases == 'None' ? '' : diseases),
                  SizedBox(height: spacing),
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
