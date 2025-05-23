import 'package:flutter/material.dart';
import '../../../model/model.dart';

class MedicationScheduleWidget extends StatelessWidget {
  final MedicationSchedule medicationSchedule;

  const MedicationScheduleWidget({super.key, required this.medicationSchedule});

  String _formatDays(List<int> days) {
    const weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days.map((i) => weekDays[i % 7]).join(', ');
  }

  String _formatTimes(List<String> times) {
    return times.map((t) => t.length >= 5 ? t.substring(0, 5) : t).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF353F54),
        border: Border.all(
          width: 1,
          color: Colors.white10,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF2C3648),
            blurRadius: 15,
            offset: Offset(2, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                medicationSchedule.medicationName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  _formatDays(medicationSchedule.scheduledDays),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _formatTimes(medicationSchedule.scheduledTimes),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
