import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uandi/app/const/storyday.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/day_card.dart';

class StoryTabBar extends StatefulWidget {
  final double height;
  const StoryTabBar({required this.height,Key? key,}) : super(key: key);

  @override
  State<StoryTabBar> createState() => _StoryTabBarState();
}

class _StoryTabBarState extends State<StoryTabBar> {
  final itemController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();
  int? storyIndex;
  final List<int> dDayList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToIndex(storyIndex!));
  }

  Future scrollToIndex(int index, {bool isAnimating = false}) async {
    const double alignment = 0;
    if (isAnimating) {
      await itemController.scrollTo(
        index: index,
        duration: const Duration(microseconds: 0),
        alignment: alignment,
      );
    } else {
      itemController.jumpTo(index: index, alignment: alignment);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: Hive.box<Couple>('couple').listenable(),
              builder: (context, Box<Couple> box, child) {
                final item = box.get(0);
                final dateFormatter = DateFormat('yyyy.MM.dd');
                final dateString = dateFormatter.format(item!.selectedDate!);
                return SizedBox(
                  height: MediaQuery.of(context).size.height- widget.height,
                  child: ScrollablePositionedList.separated(
                    // shrinkWrap: true,
                    itemScrollController: itemController,
                    itemPositionsListener: itemListener,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final storyDayText = storyDay[index].toString();
                      final dateFormatter = DateFormat('yyyy.MM.dd');
                      final date = dateFormatter.format((item.selectedDate!)
                          .add(Duration(days: storyDay[index] - 1)));

                      // dDay 계산 로직
                      final dDay = DateTime(
                        now.year,
                        now.month,
                        now.day,
                      )
                          .difference((item.selectedDate!)
                              .add(Duration(days: storyDay[index] - 1)))
                          .inDays;

                      if (dDay < 0) {
                        dDayList.add(index);
                        storyIndex = dDayList.first;
                      }
                      return DayCard(
                        storyDay: dayCount(storyDay[index], storyDayText),
                        date: '$date (${DateFormat('E', 'ko_KR').format(
                          (item.selectedDate!).add(
                            Duration(days: storyDay[index] - 1),
                          ),
                        )})',
                        dDay: dDay < 0 ? 'D$dDay' : '',
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
