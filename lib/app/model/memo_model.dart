import 'package:hive_flutter/hive_flutter.dart';

part 'memo_model.g.dart';

@HiveType(typeId: 2)
class Memo {
  @HiveField(0)
  final DateTime selectedDate;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int id;

  @HiveField(3)
  final int color;

  @HiveField(4)
  final String imagePath;

  Memo({
    required this.selectedDate,
    required this.text,
    required this.id,
    required this.color,
    required this.imagePath,
  });
}
