import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend_development/router/CustomPageRoute.dart';

class EditMedicationScheduleScreen extends StatefulWidget {
  const EditMedicationScheduleScreen({super.key});

  @override
  State<EditMedicationScheduleScreen> createState() =>
      _EditMedicationScheduleScreenState();
}

class _EditMedicationScheduleScreenState
    extends State<EditMedicationScheduleScreen> {
  final List<String> _DaysOfWeek = ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'];
  Set<String> _selectedDaysOfWeek = {};

  List<TimeOfDay> _selectedTimes = [];

  void __showDaysOfWeekDialog(BuildContext context) {
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
              child: StatefulBuilder(
                builder: (context, setLocalState) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                    children:
                    _DaysOfWeek.map((day) {
                      final isSelected = _selectedDaysOfWeek.contains(day);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedDaysOfWeek.remove(day);
                            } else {
                              _selectedDaysOfWeek.add(day);
                            }
                          });
                          setLocalState(() {});
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.05, -1.5),
                              end: Alignment(0.05, 2.5),
                              colors:
                              isSelected
                                  ? [
                                Color(0xFF34C8E8),
                                Color(0xFF4E4AF2),
                              ]
                                  : [
                                Colors.grey.shade300,
                                Colors.grey.shade400,
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            day,
                            style: TextStyle(
                              color:
                              isSelected ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              shadows:
                              isSelected
                                  ? [
                                Shadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ]
                                  : [],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCustomTimeDialog(BuildContext context) {
    int selectedHour = TimeOfDay.now().hour;
    int selectedMinute = TimeOfDay.now().minute;
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
              child: StatefulBuilder(
                builder: (context, setLocalState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Выберите время',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _selectedTimes.map((time) {
                          final isSelected = true;
                          final formatted = time.format(context);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTimes.remove(time);
                              });
                              setLocalState(() {});
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
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
                              child: Text(
                                formatted,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTimePickerItem(
                            count: 24,
                            initialItem: selectedHour,
                            onSelectedItemChanged: (index) {
                              selectedHour = index;
                            },
                          ),
                          SizedBox(width: 8),
                          Text(
                            ':',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          _buildTimePickerItem(
                            count: 60,
                            initialItem: selectedMinute,
                            onSelectedItemChanged: (index) {
                              selectedMinute = index;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                        ),
                        child: TextButton(
                          onPressed: () {
                            final newTime = TimeOfDay(
                              hour: selectedHour,
                              minute: selectedMinute,
                            );
                            if (!_selectedTimes.contains(newTime)) {
                              setState(() {
                                _selectedTimes.add(newTime);
                              });
                              setLocalState(() {});
                            }
                          },
                          child: Text(
                            'Добавить',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildTimePickerItem({
    required int count,
    required int initialItem,
    required ValueChanged<int> onSelectedItemChanged,
  }) {
    return Container(
      width: 60,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListWheelScrollView.useDelegate(
        itemExtent: 40,
        perspective: 0.003,
        diameterRatio: 1.2,
        physics: FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: initialItem),
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: count,
          builder: (context, index) {
            return Center(
              child: Text(
                index.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
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
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  'assets/images/medication_schedule/edit_medication_schedule.svg',
                  width: screenSize.width * 0.95,
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
                                    'Новое расписание',
                                    style: TextTheme.of(context).titleMedium,
                                    textAlign: TextAlign.center,
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
                                            hintText: 'Название',
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
                                    onTap:
                                        () => __showDaysOfWeekDialog(context),
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
                                              _selectedDaysOfWeek.isEmpty
                                                  ? 'День недели'
                                                  : _selectedDaysOfWeek.join(
                                                ', ',
                                              ),
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
                                  GestureDetector(
                                    onTap: () => _showCustomTimeDialog(context),
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
                                              _selectedTimes.isEmpty
                                                  ? 'Добавить время'
                                                  : _selectedTimes
                                                  .map(
                                                    (t) =>
                                                    t.format(context),
                                              )
                                                  .join(', '),
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
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CustomPageRoute(
                                            routeName: '/medication_schedule',
                                            beginOffset: Offset(1.0, 0.0),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Сохранить',
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
                                      Navigator.push(
                                        context,
                                        CustomPageRoute(
                                          routeName: '/medication_schedule',
                                          beginOffset: Offset(-1.0, 0.0),
                                        ),
                                      );
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
