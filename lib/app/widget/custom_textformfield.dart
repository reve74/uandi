import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/provider/counter_provider.dart';

class CustomTextFormField extends ConsumerWidget {
  const CustomTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorPalette.lightGray),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorPalette.lightGray),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: '기념일 내용을 적어주세요',
        hintStyle: Kangwon.lightGray_s35_w600_h24,
        contentPadding: EdgeInsets.all(8),
      ),
      maxLines: 6,
      onChanged: (value) {
        ref.read(textProvider.notifier).state = value;
      },
    );
  }
}
