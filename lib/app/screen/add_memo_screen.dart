import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/common/widgets.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/provider/providers.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/custom_textformfield.dart';
import 'package:uandi/app/widget/selecrt_color_widget.dart';

class AddMemoScreen extends ConsumerWidget {
  AddMemoScreen({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.pink,
          elevation: 0,
          title: const Text('기념일 추가', style: Kangwon.white_s30_bold_h24),
          centerTitle: true,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Padding(
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
                          label('내용'),
                          CustomTextFormField(
                            hintText: '내용을 작성해주세요',
                            controller: controller,
                          ),
                          eHeight(10),
                          label('색상'),
                          SelectColorWidget(),
                          Spacer(),
                          customElevatedBtn(
                            text: '추가하기',
                            onPressed: () {
                              // print(ref.watch(textProvider));
                              // print(controller.text);
                              // if (ref.read(textProvider).isNotEmpty) {
                              if (controller.text.isNotEmpty) {
                                addMemo(
                                  context,
                                  ref,
                                  controller,
                                );
                              } else {
                                flushBar(context);
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
}
