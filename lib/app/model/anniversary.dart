import 'package:hive_flutter/hive_flutter.dart';

part 'anniversary.g.dart';

@HiveType(typeId: 2)
class Anniversary {
  @HiveField(0)
  final DateTime? selectedDate;

  @HiveField(1)
  final String anniversary;

  @HiveField(2)
  final int id;

  Anniversary({
    required this.selectedDate,
    required this.anniversary,
    required this.id,
  });
}
