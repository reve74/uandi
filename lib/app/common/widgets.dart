import 'package:flutter/material.dart';
import 'package:uandi/app/const/kangwon.dart';

Widget label(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(text, style: Kangwon.black_s25_w600_h24),
  );
}

Widget divider() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 80.0),
    child: Divider(
      thickness: 1,
      height: 1,
    ),
  );
}