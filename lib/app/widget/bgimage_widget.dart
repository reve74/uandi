import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/utils/image_util.dart';

class BgImageWidget extends ConsumerStatefulWidget {
  BgImageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BgImageWidget> createState() => _BgImageWidgetState();
}

class _BgImageWidgetState extends ConsumerState<BgImageWidget> {
  XFile? _pickedFile;

  File? image;

  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectImage(context);
      },
      child: ValueListenableBuilder(
        valueListenable: Hive.box<Couple>('couple').listenable(),
        builder: (context, Box<Couple> box, child) {
          final item = box.get(1);
          if(item == null) {
            return _backgroundImage(context);
          }
          if (item.backgroundImage == null) {
            print(item.backgroundImage);
            return _backgroundImage(context);
          }
          print(item.backgroundImage);

          return Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width,
            child: Image.file(
              File(item.backgroundImage!),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Image.asset(
        'assets/img/couple.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Future<void> selectImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
      // _pickedFile = pickedFile;

      cropImage();
    }
  }

  Future<void> cropImage({
    bool isCircle = false,
  }) async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        // maxHeight: 200,
        // maxWidth: 400,
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
        // _croppedFile = croppedFile;
        setState(() {
          _croppedFile = croppedFile;
        });
        print(_croppedFile);
      }
      final box = await Hive.openBox<Couple>('couple');
      int id = 1;
      box.put(
        id,
        Couple(backgroundImage: _croppedFile!.path),
      );
      print('success');
      // setState(() {
      //    _croppedFile = croppedFile;
      //  });
    }
  }
}
