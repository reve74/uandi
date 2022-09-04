import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:image_cropper/image_cropper.dart';

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
              initialDateTime: ref.read(dateProvider.state).state,
              //!= null ? selectedDate : ref.watch(dateProvider.state).state,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              onDateTimeChanged: (DateTime date) async {
                ref.read(dateProvider.state).state = date;
                //TODO: 하이브에 date 저장
                save(ref);
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
    save(ref);
  }
}

void daySelect(context, WidgetRef ref, selectedDate) async {
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
              initialDateTime: ref.read(dateProvider.state).state,
              //!= null ? selectedDate : ref.watch(dateProvider.state).state,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              onDateTimeChanged: (DateTime date) async {
                ref.read(dateProvider.state).state = date;
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
  }
}

void save(WidgetRef ref) async {
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
}

String dayCount(int index, String storyDayText) {
  storyDayText = index == 1
      ? '처음 만난 날'
      : index % 365 == 0
          ? '${(index / 365).toInt()}주년'
          : '$index일';
  return storyDayText;
}

pickBackgroundImage(ImageSource source) async {
  // XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  // if (pickedImage != null) {
  //   Uint8List _image = await pickedImage.readAsBytes();
  // }
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

// pickMedia(Future<File> Function(File file)? cropImage) async {
//   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//   if (pickedFile == null) {
//     return null;
//   }
//   if (pickedFile == null) return null;
//   if (cropImage == null) {
//     return File(pickedFile.path);
//   } else {
//     final file = File(pickedFile.path);
//     return cropImage(file);
//   }
// }
//
// Future<File> cropSquareImage(File imageFile) async => await ImageCropper().cropImage(
//       sourcePath: imageFile.path,
//       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//       aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
//     );




firstAvatar(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

secondAvatar(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

// 이미지 크롭
Future<void> cropImage({required XFile pickedFile, bool isCircle = false}) async {
  if (pickedFile != null) {
    final croppedFile = await ImageCropper().cropImage(
      cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio3x2,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
     // setState(() {
     //    _croppedFile = croppedFile;
     //  });
    }
  }
}

// 이미지 선택
Future<void> selectImage() async {
  final pickedFile =
  await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    // setState(() {
    //   _pickedFile = pickedFile;
    // });
    cropImage(pickedFile: pickedFile);
  }
}
