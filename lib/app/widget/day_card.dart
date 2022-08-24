import 'package:flutter/material.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';

class DayCard extends StatelessWidget {
  DayCard({
    required this.date,
    required this.dDay,
    required this.storyDay,
    Key? key,
  }) : super(key: key);

  final String date;
  final String dDay;
  final String storyDay;

  // final List<int> story = storyDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('${story[index].toString()} 일', style: Kangwon.black_s20_w400_h24,),
              Text(
                storyDay,
                style: Kangwon.black_s20_w600_h24,
              ),
              eHeight(3),
              Text(date, style: Kangwon.black_s17_w400_h24,),
            ],
          ),
          Text(dDay, style: Kangwon.point_s20_w400_h24,),
        ],
      ),
    );
  }
}
