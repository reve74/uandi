import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uandi/app/common/widgets.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/model/memo_model.dart';
import 'package:uandi/app/screen/modify_memo_screen.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/custom_textformfield.dart';

class MemoScreen extends StatelessWidget {
  final Memo memo;
  const MemoScreen({
    required this.memo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateString = dateFormatter(date: memo.selectedDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.pink,
        elevation: 0,
        title: const Text('다이어리', style: Kangwon.white_s30_bold_h24),
        centerTitle: true,
        actions: _actions(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              eHeight(10),
              Text(
                dateString,
                style: Kangwon.black_s25_w400_h24,
              ),
              eHeight(10),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.file(
                  height: 400,
                  // width: 360,
                  fit: BoxFit.cover,
                  File(memo.imagePath),
                ),
              ),
              eHeight(10),
              // label('내용'),
              CustomTextFormField(
                label: memo.text,
                readOnly: true,
                bgColor: memo.color,
              ),
              eHeight(10),
              // Spacer(
              //   flex: 200,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionsBtn({
    required String text,
    required TextStyle textStyle,
    required Function() onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height * .075,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // _actionsBtn(
                      //   text: '수정하기',
                      //   textStyle: Kangwon.black_s20_w400_h24,
                      //   onTap: () {
                      //     Navigator.of(context).pop();
                      //     Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //         builder: (context) =>
                      //             ModifyMemoScreen(memo: memo),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // divider(),
                      _actionsBtn(
                        text: '삭제하기',
                        textStyle: Kangwon.point_s20_w400_h24,
                        onTap: () {
                          deleteMemo(context, memo.id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        icon: Icon(Icons.more_vert_outlined),
      ),
    ];
  }
}
