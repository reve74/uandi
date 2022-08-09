import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'couple.g.dart';

@HiveType(typeId: 0)
class Couple {
  @HiveField(0)
  late DateTime? selectedDate;

  @HiveField(1)
  final XFile? backgroundImage;

  Couple({
    required this.selectedDate,
    required this.backgroundImage,
  });
}
