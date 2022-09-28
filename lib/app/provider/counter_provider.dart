import 'package:flutter_riverpod/flutter_riverpod.dart';

final now = DateTime.now();

final dateProvider = StateProvider<DateTime>(
  (ref) => DateTime(
    now.year,
    now.month,
    now.day,
  ),
);

final selectColorProvider = StateProvider.autoDispose<int>((ref) => 0);

final textProvider = StateProvider.autoDispose<String>((ref) => '');
//TODO: 상태 초기화 필요
final memoDateProvider = StateProvider.autoDispose<DateTime>(
  (ref) => DateTime(
    now.year,
    now.month,
    now.day,
  ),
);

