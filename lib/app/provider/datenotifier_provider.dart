import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final dateProvider = StateNotifierProvider<DateNotifierProvider, DateTime>(
    (ref) => DateNotifierProvider());

class DateNotifierProvider extends StateNotifier<DateTime> {
  DateNotifierProvider()
      : super(
          DateTime.now(),
        );
}


// class BackgroundImageNotifierProvider extends StateNotifierProvider<XFile> {
//   BackgroundImageNotifierProvider() : super(
//
//   );
// }
