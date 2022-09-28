import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/model/memo_model.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/screen/add_memo_screen.dart';
import 'package:uandi/app/screen/memo_screen.dart';
import 'package:uandi/app/widget/bgimage_widget.dart';
import 'package:uandi/app/widget/memo_card.dart';

class CoupleTabBar extends ConsumerStatefulWidget {
  const CoupleTabBar({Key? key}) : super(key: key);

  @override
  _CoupleTabBarState createState() => _CoupleTabBarState();
}

class _CoupleTabBarState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eHeight(20),
            BgImageWidget(),
            eHeight(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('기념일 메모', style: Kangwon.black_s25_w600_h24),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddMemoScreen()));
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: Hive.box<Memo>('memo').listenable(),
                    builder: (context, Box<Memo> box, child) {
                      return Column(
                        children: List.generate(
                          box.length,
                          (index) {
                            final memo = box.getAt(index);
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MemoScreen(memo: memo!),
                                  ),
                                );
                              },
                              child: MemoCard(
                                memo: memo!,
                              ),
                            );
                          },
                        ),
                      );
                    },
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
