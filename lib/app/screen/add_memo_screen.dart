import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/common/widgets.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/provider/providers.dart';
import 'package:uandi/app/utils/image_util.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/custom_textformfield.dart';
import 'package:uandi/app/widget/selecrt_color_widget.dart';
import 'package:uandi/app/widget/select_image_widget.dart';
import 'package:uandi/app/widget/small_image_widget.dart';

class AddMemoScreen extends ConsumerStatefulWidget {
  AddMemoScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddMemoScreen> createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends ConsumerState<AddMemoScreen> {
  TextEditingController controller = TextEditingController();
  File? image;

  @override
  void dispose() {
    controller.dispose();
    image?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.pink,
          elevation: 0,
          // title: const Text('다이어리 추가', style: Kangwon.white_s30_bold_h24),
          centerTitle: true,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Container(
                  color: ColorPalette.background,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          label('날짜'),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  daySelect(
                                    context,
                                    ref,
                                    false,
                                    memoDateProvider,
                                    dateProvider,
                                  );
                                  // ref.watch(textProvider);
                                },
                                child: Consumer(
                                  builder: (context, ref, _) {
                                    final DateTime selectedDate =
                                        ref.watch(memoDateProvider.state).state;
                                    final dateString =
                                        dateFormatter(date: selectedDate);
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        dateString,
                                        style: Kangwon.black_s25_w400_h24,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          // SelectImageWidget(),
                          _selectImageWidget(),
                          eHeight(10),
                          label('내용'),
                          CustomTextFormField(
                            hintText: '내용을 작성해주세요',
                            controller: controller,
                          ),
                          eHeight(10),
                          label('카드 색상'),
                          SelectColorWidget(),
                          Spacer(),
                          customElevatedBtn(
                            text: '추가하기',
                            onPressed: () {
                              // print(ref.watch(textProvider));
                              // print(controller.text);
                              // if (ref.read(textProvider).isNotEmpty) {
                              print(image);
                              if(controller.text.isEmpty){
                                flushBar(context, '내용을 작성해주세요');
                              }
                              if(image == null) {
                                flushBar(context, '사진을 선택해주세요');

                              }
                              if (controller.text.isNotEmpty && image != null) {
                                addMemo(
                                  context: context,
                                  ref: ref,
                                  controller: controller,
                                  imagePath: ref.watch(diaryImageProvider).path,
                                );
                              }

                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _selectImageWidget() {
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
