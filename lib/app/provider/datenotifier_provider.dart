import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = StateNotifierProvider<DateNotifierProvider, DateTime>(
    (ref) => DateNotifierProvider());

class DateNotifierProvider extends StateNotifier<DateTime> {
  DateNotifierProvider()
      : super(
          DateTime.now(),
        );
}
