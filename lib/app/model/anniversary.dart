import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'anniversary.g.dart';

@HiveType(typeId: 2)
class Anniversary {
  @HiveField(0)
  final DateTime? selectedDate;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int id;

  @HiveField(3)
  final int color;

  Anniversary({
    this.selectedDate,
    required this.text,
    required this.id,
    required this.color,
  });
}
