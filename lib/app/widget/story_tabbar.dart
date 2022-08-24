import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/const/storyday.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/model/day.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/day_card.dart';

class StoryTabBar extends ConsumerWidget {
  const StoryTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    // final selectedDate = ref.watch(dateProvider.state).state;
    //
    // final d100 = selectedDate.add(const Duration(days: 99));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Text(
            //   '${DateTime(
            //         now.year,
            //         now.month,
            //         now.day,
            //       ).difference(ref.watch(dateProvider.state).state).inDays + 1}',
            //   style: Kangwon.black_s35_w400_h24,
            // ),
            // Text(
            //   '${d100.year}.${d100.month}.${d100.day}. ${DateFormat('E', 'ko_KR').format(d100)}',
            //   style: Kangwon.black_s20_w400_h24,
            // ),

            ValueListenableBuilder(
              valueListenable: Hive.box<Couple>('couple').listenable(),
              builder: (context, Box<Couple> box, child) {
                final item = box.get(0);
                final dateFormatter = DateFormat('yyyy.MM.dd');
                final dateString = dateFormatter.format(item!.selectedDate!);
                // return Text(
                //   '$dateString.${DateFormat('E', 'ko_KR').format(item.selectedDate!)}',
                //   style: Kangwon.black_s20_w400_h24,
                // );
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final storyDayText = storyDay[index].toString();
                    final dateFormatter = DateFormat('yyyy.MM.dd');
                    final date = dateFormatter.format((item.selectedDate!)
                        .add(Duration(days: storyDay[index] - 1)));

                    final dDay = DateTime(now.year,now.month,now.day,
                    ).difference((item.selectedDate!).add(
                        Duration(days: storyDay[index] - 1))).inDays;

                    return DayCard(
                      storyDay: dayCount(storyDay[index], storyDayText),
                      date: '$date (${DateFormat('E', 'ko_KR').format(
                        (item.selectedDate!).add(
                          Duration(days: storyDay[index] - 1),
                        ),
                      )})',
                      dDay: dDay < 0 ?'D$dDay' : '',
                      // dDay: 'D-${(item.selectedDate!).add(
                      //   Duration(days: storyDay[index] - 1),
                      // ).difference(DateTime(now.year,now.month,now.day)).inDays}',
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(),
                    );
                  },
                  itemCount: storyDay.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
