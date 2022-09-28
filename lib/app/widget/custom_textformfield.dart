import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:uandi/app/utils/util.dart';

class CustomTextFormField extends ConsumerWidget {
  final String? hintText;
  final bool? readOnly;
  final String? label;
  final int? bgColor;
  final TextEditingController? controller;
  const CustomTextFormField({
    this.hintText,
    this.label,
    this.readOnly,
    this.bgColor,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (label != null) {
      ref.watch(textProvider.notifier).update((state) => label!);
    }
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.lightGray),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: readOnly != true ? const BorderSide(color: ColorPalette.lightGray) : BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
        hintStyle: Kangwon.lightGray_s35_w600_h24,
        contentPadding: const EdgeInsets.all(8),
        filled: readOnly == true ? true : null,
        fillColor: readOnly == true ? getBGClr(bgColor!) : null,
      ),
      readOnly: readOnly ?? false,
      initialValue: label,
      maxLines: 6,
      controller: controller,
      // onChanged: (value) {
      //   final printValue =
      //       ref.watch(textProvider.notifier).update((state) => value);
      //   print(printValue);
      //   // ref.read(textProvider.notifier).state = value;
      // },
      style: Kangwon.black_s25_w400_h24,
    );
  }
}
