import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/utils/image_util.dart';
import 'package:uandi/app/utils/util.dart';

class BgImageWidget extends ConsumerStatefulWidget {
  BgImageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BgImageWidget> createState() => _BgImageWidgetState();
}

class _BgImageWidgetState extends ConsumerState<BgImageWidget> {

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    DateTime selectedDate = DateTime(
      now.year,
      now.month,
      now.day,
    );

    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: Hive.box<Couple>('couple').listenable(),
          builder: (context, Box<Couple> box, child) {
            final item = box.get(3);
            if (item == null) {
              return _backgroundImage(context);
            }
            // if (item.backgroundImage == null) {
            //   print(item.backgroundImage);
            //   return _backgroundImage(context);
            // }
            return GestureDetector(
              onTap: () {
                ImageUtil().selectImage(
                  context: context,
                  imageType: 3,
                );
              },
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.file(
                  File(item.backgroundImage!),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        eHeight(10),
        SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _circleAvatar(id: 1),
              ValueListenableBuilder(
                valueListenable: Hive.box<Couple>('couple').listenable(),
                builder: (context, Box<Couple> box, child) {
                  final item = box.get(0);
                  return _dayCount(
                    context,
                    ref,
                    selectedDate,
                    Text(
                      '${DateTime(
                            now.year,
                            now.month,
                            now.day,
                          ).difference(item!.selectedDate as DateTime).inDays + 1}',
                      style: Kangwon.black_s25_w400_h24,
                    ),
                  );
                },
              ),
              _circleAvatar(id: 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget smile() {
    return Image.asset(
      'assets/img/happy.png',
      height: 80,
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ImageUtil().selectImage(
          context: context,
          imageType: 3,
        );
      },
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/img/couple.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _dayCount(context, ref, selectedDate, Text day) {
    return Column(
      children: [
        eHeight(10),
        IconButton(
          iconSize: 50,
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
      ],
    );
  }

  Widget _circleAvatar({required int id}) {
    return GestureDetector(
      onTap: () => ImageUtil().selectImage(
        context: context,
        imageType: id,
        isCircle: true,
      ),
      child: ValueListenableBuilder(
        valueListenable: Hive.box<Couple>('couple').listenable(),
        builder: (context, Box<Couple> box, child) {
          final item = box.get(id);
          if (item == null) {
            return smile();
          }
          return CircleAvatar(
            backgroundImage: FileImage(
              File(
                id == 1 ? item.circleAvatar1! : item.circleAvatar2!,
              ),
            ),
            radius: 40,
          );
        },
      ),
    );
  }
}
