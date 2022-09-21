import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectColorProvider = StateProvider<int>((ref) => 0);
final textProvider = StateProvider<String>((ref) => '');

final now = DateTime.now();

final dateProvider = StateProvider<DateTime>(
  (ref) => DateTime(
    now.year,
    now.month,
    now.day,
  ),
);

final anniversaryDateProvider = StateProvider(
  (ref) => DateTime(
    now.year,
    now.month,
    now.day,
  ),
);

final backgroundImageProvider = StateProvider<Uint8List>((ref) => Uint8List(0));
final selectedImage1Provider = StateProvider<Uint8List>((ref) => Uint8List(0));
final selectedImage2Provider = StateProvider<Uint8List>((ref) => Uint8List(0));
