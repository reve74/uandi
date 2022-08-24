import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:uandi/app/utils/util.dart';

class CoupleTabBar extends ConsumerWidget {
  const CoupleTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eHeight(20),
        _backgroundImage(context),
        // Container(
        //   child: Consumer(
        //     builder: (context, ref, _) {
        //       final DateTime selectedDate = ref.watch(dateProvider.state).state;
        //       return Text(
        //         '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
        //       );
        //     },
        //   ),
        // ),
        eHeight(10),
        ValueListenableBuilder(
          valueListenable: Hive.box<Couple>('couple').listenable(),
          builder: (context, Box<Couple> box, child) {
            final item = box.get(0);
            if (item == null) {
              return _dayCount(
                context,
                ref,
                selectedDate,
                Text(
                  '${DateTime(
                        now.year,
                        now.month,
                        now.day,
                      ).difference(selectedDate).inDays + 1}',
                  style: Kangwon.black_s35_w400_h24,
                ),
              );
            }

            final dateFormatter = DateFormat('yyyy.MM.dd');
            final dateString =
                dateFormatter.format(item.selectedDate as DateTime);

            print(dateString);
            return _dayCount(
              context,
              ref,
              selectedDate,
              Text(
                '${DateTime(
                      now.year,
                      now.month,
                      now.day,
                    ).difference(item.selectedDate as DateTime).inDays + 1}',
                style: Kangwon.black_s35_w400_h24,
              ),
            );
          },
        ),
        eHeight(20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('기념일', style: Kangwon.black_s25_w600_h24),
              IconButton(onPressed: (){}, icon: Icon(Icons.add))
            ],
          ),
        ),
      ],
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Image.asset(
        'assets/img/couple.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _dayCount(context, ref, selectedDate, Text day) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/img/smile.png',
            height: 80,
          ),
          Column(
            children: [
              IconButton(
                iconSize: 55,
                onPressed: () {
                  onHearthPressed(context, ref, selectedDate);
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: const Icon(
                  Icons.favorite,
                  color: ColorPalette.point,
                ),
              ),
              day,
              // Text(
              //   '${DateTime(
              //     now.year,
              //     now.month,
              //     now.day,
              //   ).difference(selectedDate).inDays + 1}',
              //   style: Kangwon.black_s35_w400_h24,
              // ),
              // Text(
              //   '${DateTime(
              //     now.year,
              //     now.month,
              //     now.day,
              //   ).difference(ref.watch(dateProvider.state).state).inDays + 1}',
              //   style: Kangwon.black_s35_w400_h24,
              // ),
              // Text(
              //   '${DateTime(
              //     now.year,
              //     now.month,
              //     now.day,
              //   ).difference(item.selectedDate as DateTime).inDays + 1}',
              //   style: Kangwon.black_s35_w400_h24,
              // ),
            ],
          ),
          Image.asset(
            'assets/img/smile.png',
            height: 80,
          ),
        ],
      ),
    );
  }
}
