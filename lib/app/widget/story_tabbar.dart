import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/provider/counter_provider.dart';

class StoryTabBar extends ConsumerWidget {
  const StoryTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final selectedDate = ref.watch(dateProvider.state).state;

    final d100 = selectedDate.add(const Duration(days: 99));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateTime(
                    now.year,
                    now.month,
                    now.day,
                  ).difference(ref.watch(dateProvider.state).state).inDays + 1}',
              style: Kangwon.black_s35_w400_h24,
            ),
            Text(
              '${d100.year}.${d100.month}.${d100.day}',
              style: Kangwon.black_s20_w400_h24,
            ),
          ],
        ),
      ),
    );
  }
}
