import 'package:flutter/material.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/model/anniversary.dart';
import 'package:uandi/app/utils/util.dart';

class AnniversaryCard extends StatelessWidget {
  final Anniversary anniversary;

  const AnniversaryCard({
    required this.anniversary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateString = dateFormatter(date: anniversary.selectedDate!);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBGClr(anniversary.color),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(dateString, style: Kangwon.black_s17_w400_h24,),
              Text(anniversary.text, style: Kangwon.black_s20_w500_h24,),

            ],
          ),
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return ColorPalette.pink;
      case 1:
        return ColorPalette.peach;
      case 2:
        return ColorPalette.lightPink1;
      case 3:
        return ColorPalette.lightPink;
      case 4:
        return ColorPalette.beige;
      default:
        return ColorPalette.pink;
    }
  }
}
