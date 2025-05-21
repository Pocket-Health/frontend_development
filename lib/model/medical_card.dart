import 'package:hive/hive.dart';

part 'medical_card.g.dart';

@HiveType(typeId: 0)
class MedicalCard extends HiveObject {
  @HiveField(0)
  String fullName;

  @HiveField(1)
  int height;

  @HiveField(2)
  double weight;

  @HiveField(3)
  String bloodType;

  @HiveField(4)
  String allergies;

  @HiveField(5)
  String diseases;

  MedicalCard({
    required this.fullName,
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.allergies,
    required this.diseases,
  });

  factory MedicalCard.fromJson(Map<String, dynamic> json) {
    return MedicalCard(
      fullName: json['fullName'],
      height: json['height'],
      weight: (json['weight'] as num).toDouble(),
      bloodType: json['bloodType'],
      allergies: json['allergies'],
      diseases: json['diseases'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'height': height,
      'weight': weight,
      'bloodType': bloodType,
      'allergies': allergies,
      'diseases': diseases,
    };
  }
}