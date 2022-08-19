import 'dart:io';
import 'dart:typed_data';

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

final backgroundImageProvider = StateProvider<Uint8List>((ref) => Uint8List(0));
final selectedImage1Provider = StateProvider<Uint8List>((ref) => Uint8List(0));
final selectedImage2Provider = StateProvider<Uint8List>((ref) => Uint8List(0));
