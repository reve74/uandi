import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/common/widgets.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/provider/providers.dart';
import 'package:uandi/app/utils/image_util.dart';
import 'package:uandi/app/widget/small_image_widget.dart';

class SelectImageWidget extends ConsumerWidget {
  SelectImageWidget({Key? key}) : super(key: key);


  File? image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(diaryImageProvider);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label('사진'),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: ColorPalette.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  ImageUtil().selectDiaryImage(ref: ref, autoDisposeProvider: diaryImageProvider);
                  image = File(provider.path);

                  // ImageUtil().selectDiaryImage(ref: ref, autoDisposeProvider: diaryImageProvider).then((value) {
                  //   ref.read(diaryImageProvider.state).update((state) => value);
                  // });


                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 2,
                    color: ColorPalette.pink,
                  ),
                  minimumSize: const Size(90, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: ColorPalette.pink,
                  size: 30,
                ),
              ),
              image != null
                  ? SmallImageWidget(imagePath: provider,)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
