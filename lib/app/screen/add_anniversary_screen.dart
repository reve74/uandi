import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/model/anniversary.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/custom_textformfield.dart';
import 'package:uandi/app/widget/selecrt_color_widget.dart';

class AddAnniversaryScreen extends ConsumerWidget {
  const AddAnniversaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final date = ref.watch(dateProvider);
    String text = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.pink,
        elevation: 0,
        title: const Text('기념일 추가', style: Kangwon.white_s30_bold_h24),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(flex: 10),
              label('날짜'),
              InkWell(
                onTap: () {
                  daySelect(context, ref, anniversaryDateProvider, false);
                },
                child: Consumer(
                  builder: (context, ref, _) {
                    final DateTime selectedDate =
                        ref.watch(anniversaryDateProvider.state).state;
                    final dateString = dateFormatter(date: selectedDate);
                    return Text(
                      dateString,
                      style: Kangwon.black_s25_w400_h24,
                    );
                  },
                ),
              ),
              eHeight(10),
              label('내용'),
              CustomTextFormField(),
              eHeight(10),
              label('색상'),
              SelectColorWidget(),
              Spacer(
                flex: 200,
              ),
              ElevatedButton(
                onPressed: () async {
                  final box = await Hive.openBox<Anniversary>('anniversary');
                  int id = 0;

                  if (box.isNotEmpty) {
                    final prevItem = box.getAt(box.length - 1);
                    if (prevItem != null) {
                      id = prevItem.id + 1;
                    }
                  }
                  box.put(
                    id,
                    Anniversary(
                      selectedDate: ref.read(anniversaryDateProvider),
                      text: ref.read(textProvider),
                      id: id,
                      color: ref.read(selectColorProvider),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('추가하기', style: Kangwon.white_s25_w600_h24),
                ),
                style: ElevatedButton.styleFrom(
                  primary: ColorPalette.pink,
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
