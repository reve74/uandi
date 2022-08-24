import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'dart:typed_data';


void onHearthPressed(context, WidgetRef ref, selectedDate) async {
  final DateTime now = DateTime.now();

  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: ref.watch(dateProvider.state).state,
              //!= null ? selectedDate : ref.watch(dateProvider.state).state,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              onDateTimeChanged: (DateTime date) async {
                ref.watch(dateProvider.state).state = date;
                //TODO: 하이브에 date 저장
                final box = await Hive.openBox<Couple>('couple');
                int id = 0;
                box.put(
                  id,
                  Couple(
                    selectedDate: ref.watch(dateProvider.state).state,
                    backgroundImage: ref.watch(backgroundImageProvider.state).state,
                    selectedImage1: ref.watch(selectedImage1Provider.state).state,
                    selectedImage2: ref.watch(selectedImage2Provider.state).state,
                  ),
                );
                print(box.values);

                print('succees');

                // setState(() {
                //   selectedDate = date;
                // });
              },
            ),
          ),
        );
      },
    );
  }
  if (Platform.isAndroid) {
    print('button');
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: ref.watch(dateProvider.state).state,
      firstDate: DateTime(1900),
      lastDate: selectedDate,
    );
    if (date == null) return;
    ref.watch(dateProvider.state).state = date;
    //TODO: 하이브에 date 저장

    final box = await Hive.openBox<Couple>('couple');
    int id = 0;
    box.put(
      id,
      Couple(
        selectedDate: ref.watch(dateProvider.state).state,
        backgroundImage: ref.watch(backgroundImageProvider.state).state,
        selectedImage1: ref.watch(selectedImage1Provider.state).state,
        selectedImage2: ref.watch(selectedImage2Provider.state).state,
      ),
    );
    print(box.values);
  }
}

String dayCount(int index, String storyDayText) {
  storyDayText = index == 1 ? '처음 만난 날' : index % 365 == 0 ? '${(index / 365).toInt()}주년' : '$index일';
  return storyDayText;
}

void pickImage() async{
  // XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  // if (pickedImage != null) {
  //   Uint8List _image = await pickedImage.readAsBytes();
  // }
}
