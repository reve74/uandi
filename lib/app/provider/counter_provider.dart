import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final counterProvider = StateProvider((ref) => 0);

final dateProvider = StateProvider(
  (ref) => DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ),
);

final backgroundImageProvider = StateProvider((ref) => File);
final selectedImage1Provider = StateProvider((ref) => File);
final selectedImage2Provider = StateProvider((ref) => File);
