import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/feature/medication_schedule/widget/medication_schedule.dart';
import 'package:frontend_development/model/model.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';
import 'package:hive/hive.dart';

import '../../../repository/repository.dart';

class MedicationScheduleScreen extends StatefulWidget{
  const MedicationScheduleScreen({super.key});

  @override
  State<MedicationScheduleScreen> createState() => _MedicationScheduleScreenState();
}

class _MedicationScheduleScreenState extends State<MedicationScheduleScreen>{
  late MedicationScheduleList medicationScheduleList;

  Future<void> _deleteSchedule(String id) async {
    AppMetrica.reportEvent('delete_schedule');
    final responseCode = await MedicationScheduleRepository().deleteMedicationSchedule(id);
    if (responseCode == 204) {
      AppMetrica.reportEvent('success_delete_schedule');
      setState(() {
        final box = Hive.box<MedicationScheduleList>('medicationScheduleListBox');
        medicationScheduleList = box.get('medicationScheduleList') ?? MedicationScheduleList(schedules: []);
      });
    } else if (responseCode == 404) {
      AppMetrica.reportError(message: 'error_delete_schedule: $responseCode');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            textAlign: TextAlign.center,
            'Данное расписание не найдено',
            style: TextStyle(color: Colors.black),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      AppMetrica.reportError(message: 'error_delete_schedule: $responseCode');
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
    }
  }

  @override
  void initState() {
    super.initState();
    AppMetrica.reportEvent('open_medication_schedule_screen');
    final box = Hive.box<MedicationScheduleList>('medicationScheduleListBox');
    medicationScheduleList = box.get('medicationScheduleList') ?? MedicationScheduleList(schedules: []);
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
                children: medicationScheduleList.schedules.map((medicationSchedule) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.only(top: spacing),
                      width: screenSize.width * 0.87,
                      child: Slidable(
                        key: ValueKey(medicationSchedule.id),
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
                                    arguments: medicationSchedule,
                                    beginOffset: Offset(1.0, 0.0),
                                  ),
                                );
                              },
                              child: _buildSlidableAction('assets/icons/edit_medication_schedule.svg'),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () => _showDeleteDialog(medicationSchedule.id),
                              child: _buildSlidableAction('assets/icons/delete_medication_schedule.svg'),
                            ),
                          ],
                        ),
                        child: MedicationScheduleWidget(medicationSchedule: medicationSchedule),
                      ),
                    ),
                  );
                }).toList(),
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

  Widget _buildSlidableAction(String assetPath) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFF353F54),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: SvgPicture.asset(assetPath, width: 87),
      ),
    );
  }

  void _showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Вы уверены, что хотите удалить расписание?', textAlign: TextAlign.center),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildDialogButton('Отмена', () => Navigator.pop(context), Colors.grey.shade300),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildDialogButton('Удалить', () {
                      _deleteSchedule(id);
                      Navigator.pop(context);
                    }, Color(0xFF4E4AF2), textColor: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogButton(String text, VoidCallback onPressed, Color color, {Color textColor = Colors.black}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
      ),
    );
  }
}