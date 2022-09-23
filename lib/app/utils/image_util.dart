import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/provider/counter_provider.dart';

class ImageUtil {
  void saveBackgroundImage(WidgetRef ref) async {
    final box = await Hive.openBox<Couple>('couple');
    int id = 0;
    box.put(
      id,
      Couple(
        backgroundImage: ref.watch(backgroundImageProvider.state).state,
      ),
    );
  }

  Future pickBackgroundImage(ImageSource source) async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No image selected');
  }


  pickAvatarImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No image selected');
  }

// 이미지 크롭
  Future<void> cropImage(
      {required XFile pickedFile, bool isCircle = false}) async {
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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // setState(() {
      //   _pickedFile = pickedFile;
      // });
      cropImage(pickedFile: pickedFile);
    }
  }

}