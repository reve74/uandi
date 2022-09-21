import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:uandi/app/utils/util.dart';

class SelectScreen extends ConsumerWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      backgroundColor: ColorPalette.pink,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 100),
            const Text(
              '처음 만난 날을',
              style: Kangwon.white_s45_bold_h48,
            ),
            const Text(
              '선택해주세요',
              style: Kangwon.white_s45_bold_h48,
            ),
            eHeight(20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.favorite_outlined,
                size: 50,
                color: ColorPalette.point,
              ),
            ),
            eHeight(4),
            InkWell(
              onTap: () {
                // onHearthPressed(context, ref, selectedDate);
                daySelect(
                  context,
                  ref,
                  dateProvider,
                  true,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer(
                      builder: (context, ref, _) {
                        final DateTime selectedDate =
                            ref.watch(dateProvider.state).state;
                        final dateString = dateFormatter(date: selectedDate);
                        return Text(
                          dateString,
                          style: Kangwon.black_s35_w600_h24,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 75),
            GestureDetector(
              onTap: () {
                saveDate(ref);
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    color: ColorPalette.white, shape: BoxShape.circle),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 40,
                ),
              ),
            ),
            Spacer(flex: 25),
          ],
        ),
      ),
    );
  }
}
