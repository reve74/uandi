import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/model/memo_model.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/provider/counter_provider.dart';

void onHearthPressed(context, WidgetRef ref, selectedDate) async {
  // final DateTime now = DateTime.now();

  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: ref.read(dateProvider.state).state,
              //!= null ? selectedDate : ref.watch(dateProvider.state).state,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              onDateTimeChanged: (DateTime date) async {
                ref.read(dateProvider.state).state = date;
                //TODO: 하이브에 date 저장
                saveDate(ref);
              },
            ),
          ),
        );
      },
    );
  }
  if (Platform.isAndroid) {
    print('button');
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: ref.watch(dateProvider.state).state,
      firstDate: DateTime(1900),
      lastDate: selectedDate,
    );
    if (date == null) return;
    ref.watch(dateProvider.state).state = date;
    // 하이브에 date 저장
    saveDate(ref);
  }
}

void daySelect(
  context,
  WidgetRef ref,
  bool isSelectedDate,
  AutoDisposeStateProvider? autoDisposeStateProvider,
  StateProvider? stateProvider,
) async {
  final DateTime now = DateTime.now();
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: ref
                  .watch(isSelectedDate == true
                      ? stateProvider!.state
                      : autoDisposeStateProvider!.state)
                  .state,
              //!= null ? selectedDate : ref.watch(dateProvider.state).state,
              maximumDate: isSelectedDate == true
                  ? DateTime(
                      now.year,
                      now.month,
                      now.day,
                    )
                  : null,
              onDateTimeChanged: (DateTime date) async {
                ref
                    .watch(isSelectedDate == true
                        ? stateProvider!.state
                        : autoDisposeStateProvider!.state)
                    .state = date;
              },
            ),
          ),
        );
      },
    );
  }
  if (Platform.isAndroid) {
    print('button');
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: ref
          .watch(isSelectedDate == true
              ? stateProvider!.state
              : autoDisposeStateProvider!.state)
          .state,
      firstDate: DateTime(1900),
      lastDate: selectedDate,
    );
    if (date == null) return;
    ref
        .watch(isSelectedDate == true
            ? stateProvider!.state
            : autoDisposeStateProvider!.state)
        .state = date;
  }
}

String dayCount(int index, String storyDayText) {
  storyDayText = index == 1
      ? '처음 만난 날'
      : index % 365 == 0
          ? '${(index / 365).toInt()}주년'
          : '$index일';
  return storyDayText;
}

void saveDate(WidgetRef ref) async {
  final box = await Hive.openBox<Couple>('couple');
  int id = 0;
  box.put(
    id,
    Couple(selectedDate: ref.watch(dateProvider.state).state),
  );
  print(box.values);
  print('succees');
}

String dateFormatter({required DateTime date}) {
  final dateFormatter = DateFormat('yyyy.MM.dd');
  final dateString = dateFormatter.format(date);
  return dateString;
}



// 기념일 추가
void addMemo(context, WidgetRef ref, TextEditingController controller) async{
  final box = await Hive.openBox<Memo>('memo');
  int id = 0;

  if (box.isNotEmpty) {
    final prevItem = box.getAt(box.length - 1);
    if (prevItem != null) {
      id = prevItem.id + 1;
    }
  }
  box.put(
    id,
    Memo(
      selectedDate: ref.read(memoDateProvider),
      // text: ref.watch(textProvider),
      text: controller.text.trim(),
      id: id,
      color: ref.read(selectColorProvider),
    ),
  );
  Navigator.of(context).pop();
}

void deleteMemo(context, int id) async {
  final box = await Hive.openBox<Memo>('memo');
  box.delete(id);
  Navigator.of(context).pop();
}

Color getBGClr(int no) {
  switch (no) {
    case 0:
      return ColorPalette.beige;
    case 1:
      return ColorPalette.lightPink;
    case 2:
      return ColorPalette.lightPink1;
    case 3:
      return ColorPalette.pink;
    case 4:
      return ColorPalette.peach;
    default:
      return ColorPalette.beige;
  }
}

void flushBar(BuildContext context) {
  Flushbar(
    messageText: const Text(
      '내용을 작성해주세요.',
      style: Kangwon.black_s20_w600_h24,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * .1,
    ),
    backgroundColor: ColorPalette.white,
    borderRadius: BorderRadius.circular(15),
    borderColor: ColorPalette.peach,
    duration: const Duration(
      milliseconds: 2000,
    ),

  ).show(context);
}

// 기념일 수정
// void modifyMemo(
//   context,
//   int id,
//   Memo memo,
//   WidgetRef ref,
// ) async {
//   final box = await Hive.openBox<Memo>('memo');
//   box.put(
//     id,
//     Memo(
//       selectedDate: ref.watch(memoDateProvider),
//       text: ref.watch(textProvider),
//       id: id,
//       color: ref.watch(selectColorProvider),
//     ),
//   );
//   print(box.length);
//   Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MemoScreen(memo: memo),
//       ),
//       (route) => false);
// }
