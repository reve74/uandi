import 'dart:io';

import 'package:flutter/material.dart';

class SmallImageWidget extends StatelessWidget {
  final File imagePath;
  const SmallImageWidget({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      clipBehavior: Clip.antiAlias,
      height: 80,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.file(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
