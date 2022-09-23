import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'couple.g.dart';

@HiveType(typeId: 1)
class Couple {
  @HiveField(0)
  final DateTime? selectedDate;

  @HiveField(1)
  final String? backgroundImage;

  @HiveField(2)
  final String? circleAvatar1;

  @HiveField(3)
  final String? circleAvatar2;

  Couple({
    this.selectedDate,
    this.backgroundImage,
    this.circleAvatar1,
    this.circleAvatar2,
  });
}
