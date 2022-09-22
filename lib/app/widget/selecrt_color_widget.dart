import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/provider/counter_provider.dart';

class SelectColorWidget extends ConsumerWidget {
  const SelectColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectColor = ref.watch(selectColorProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: List<Widget>.generate(
            5,
                (index) {
              return GestureDetector(
                onTap: () {
                  ref.read(selectColorProvider.notifier).update((state) => index);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 16.5,
                    backgroundColor: ColorPalette.black,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: index == 0
                          ? ColorPalette.beige
                          : index == 1
                          ? ColorPalette.lightPink
                          : index == 2
                          ? ColorPalette.lightPink1
                          : index == 3
                          ? ColorPalette.pink
                          : ColorPalette.peach,
                      child: selectColor == index
                          ? Icon(
                        Icons.done,
                        color: ColorPalette.black1,
                        size: 16.0,
                      )
                          : Container(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
