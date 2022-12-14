import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/model/memo_model.dart';

class ImageUtil {
  XFile? _pickedFile;
  File? image;
  CroppedFile? _croppedFile;

  Future selectDiaryImage({
    required WidgetRef ref,
    required AutoDisposeStateProvider<File> autoDisposeProvider,
  }) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ref.read(autoDisposeProvider.notifier).update(
            (state) => File(pickedFile.path),
          );
      // print(ref.watch(stateProvider.state).state);

      return File(pickedFile.path);
    }
  }

  Future<void> selectImage({
    required BuildContext context,
    required int imageType,
    bool isCircle = false,
  }) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedFile = pickedFile;

      cropImage(
        imageType: imageType,
        isCircle: isCircle,
      );
    }
  }

  Future<void> cropImage({
    required bool isCircle,
    required int imageType,
  }) async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        // maxHeight: 1080,
        // maxWidth: 1920,
        compressQuality: 100,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
              // title: 'Cropper',
              ),
        ],
      );
      if (croppedFile != null) {
        _croppedFile = croppedFile;
        print(_croppedFile);
      }
      final box = await Hive.openBox<Couple>('couple');
      final memoBox = await Hive.openBox<Memo>('memo');

      switch (imageType) {
        case 1:
          return box.put(1, Couple(circleAvatar1: _croppedFile!.path));
        case 2:
          return box.put(2, Couple(circleAvatar2: _croppedFile!.path));
        case 3:
          return box.put(3, Couple(backgroundImage: _croppedFile!.path));
      }
    }
  }

  // ????????? ??????
  void deleteImage(context, int id) async {
    final box = await Hive.openBox<Couple>('couple');
    for (int i = 1; i < 4; i++) {
      box.delete(i);
    }
    Navigator.of(context).pop();
    print('sc');
  }

  // void saveBackgroundImage(WidgetRef ref) async {
  //   final box = await Hive.openBox<Couple>('couple');
  //   int id = 0;
  //   box.put(
  //     id,
  //     Couple(
  //       backgroundImage: ref.watch(backgroundImageProvider.state).state,
  //     ),
  //   );
  // }

  // Future pickBackgroundImage(ImageSource source) async {
  //   XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (file != null) {
  //     return await file.readAsBytes();
  //   }
  //   print('No image selected');
  // }

  // pickAvatarImage() async {
  //   XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (file != null) {
  //     return await file.readAsBytes();
  //   }
  //   print('No image selected');
  // }

// ????????? ??????
//   Future<void> cropImage({
//     required XFile pickedFile,
//     bool isCircle = false,
//   }) async {
//     if (pickedFile != null) {
//       final croppedFile = await ImageCropper().cropImage(
//         cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
//         sourcePath: pickedFile.path,
//         compressFormat: ImageCompressFormat.jpg,
//         // maxHeight: 200,
//         // maxWidth: 400,
//         compressQuality: 100,
//         aspectRatioPresets: [
//           CropAspectRatioPreset.ratio3x2,
//         ],
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: 'Cropper',
//               toolbarColor: Colors.deepOrange,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(
//             title: 'Cropper',
//           ),
//         ],
//       );
//       if (croppedFile != null) {
//         // setState(() {
//         //    _croppedFile = croppedFile;
//         //  });
//       }
//     }
//   }

// ????????? ??????
//   Future<void> selectImage(BuildContext context) async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       // setState(() {
//       //   _pickedFile = pickedFile;
//       // });
//       cropImage(pickedFile: pickedFile);
//     }
//   }

}
