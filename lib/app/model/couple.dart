import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'couple.g.dart';

@HiveType(typeId: 1)
class Couple {
  @HiveField(0)
  final DateTime? selectedDate;

  @HiveField(1)
  final Uint8List? backgroundImage;

  @HiveField(2)
  final Uint8List? selectedImage1;

  @HiveField(3)
  final Uint8List? selectedImage2;

  Couple({
    this.selectedDate,
    this.backgroundImage,
    this.selectedImage1,
    this.selectedImage2,
  });
}
