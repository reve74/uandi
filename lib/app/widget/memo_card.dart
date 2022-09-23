import 'package:flutter/material.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/model/memo_model.dart';
import 'package:uandi/app/utils/util.dart';

class MemoCard extends StatelessWidget {
  final Memo memo;

  const MemoCard({
    required this.memo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateString = dateFormatter(date: memo.selectedDate!);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: getBGClr(memo.color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                dateString,
                style: Kangwon.black_s17_w400_h24,
              ),
              Text(
                memo.text,
                style: Kangwon.black_s20_w500_h24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
