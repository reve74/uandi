import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/model/memo_model.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/small_image_widget.dart';
import 'package:flutter/services.dart' show rootBundle;



class MemoCard extends StatelessWidget {
  final Memo memo;

  const MemoCard({
    required this.memo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateString = dateFormatter(date: memo.selectedDate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.1,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: getBGClr(memo.color),
        ),
        child: Row(
          children: [
            SmallImageWidget(imagePath: File(memo.imagePath)),
            eWidth(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateString,
                    style: Kangwon.black_s17_w400_h24,
                  ),
                  Text(
                    memo.text,
                    style: Kangwon.black_s20_w500_h24,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
