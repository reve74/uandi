import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
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
      children: [
        eHeight(20),
        _backgroundImage(context),
        Container(
          child: Consumer(
            builder: (context, ref, _) {
              final DateTime selectedDate = ref.watch(dateProvider.state).state;
              return Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
              );
            },
          ),
        ),
        Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/img/smile.png',
                height: 70,
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
                      color: ColorPalette.lightPink,
                    ),
                  ),
                  Text(
                    '${DateTime(
                          now.year,
                          now.month,
                          now.day,
                        ).difference(ref.watch(dateProvider.state).state).inDays + 1}',
                    style: Kangwon.black_s35_w400_h24,
                  ),
                ],
              ),
              Image.asset(
                'assets/img/smile.png',
                height: 70,
              ),
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
}
