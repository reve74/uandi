import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/model/memo_model.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:uandi/app/screen/add_memo_screen.dart';
import 'package:uandi/app/screen/memo_screen.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/memo_card.dart';

class CoupleTabBar extends ConsumerStatefulWidget {
  const CoupleTabBar({Key? key}) : super(key: key);

  @override
  _CoupleTabBarState createState() => _CoupleTabBarState();
}

class _CoupleTabBarState extends ConsumerState {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final now = DateTime.now();

    Future<void> _cropImage() async {
      if (_pickedFile != null) {
        final croppedFile = await ImageCropper().cropImage(
          // cropStyle: CropStyle.circle,
          sourcePath: _pickedFile!.path,
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
          setState(() {
            _croppedFile = croppedFile;
          });
        }
      }
    }

    Future<void> _uploadImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedFile = pickedFile;
        });
        _cropImage();
      }
    }

    Widget _image() {
      if (_croppedFile != null) {
        return Container(
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width,
            child: Image.file(File(_croppedFile!.path)));
      } else {
        return _backgroundImage(context);
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          eHeight(20),
          GestureDetector(
              onTap: () async {
                _uploadImage();
              },
              child: _image()),
          eHeight(10),
          ValueListenableBuilder(
            valueListenable: Hive.box<Couple>('couple').listenable(),
            builder: (context, Box<Couple> box, child) {
              final item = box.get(0);
              if (item == null) {
                return _dayCount(
                  context,
                  ref,
                  selectedDate,
                  Text(
                    '${DateTime(
                          now.year,
                          now.month,
                          now.day,
                        ).difference(selectedDate).inDays + 1}',
                    style: Kangwon.black_s35_w400_h24,
                  ),
                );
              }

              final dateFormatter = DateFormat('yyyy.MM.dd');
              final dateString =
                  dateFormatter.format(item.selectedDate as DateTime);

              return _dayCount(
                context,
                ref,
                selectedDate,
                Text(
                  '${DateTime(
                        now.year,
                        now.month,
                        now.day,
                      ).difference(item.selectedDate as DateTime).inDays + 1}',
                  style: Kangwon.black_s35_w400_h24,
                ),
              );
            },
          ),
          eHeight(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('기념일 메모', style: Kangwon.black_s25_w600_h24),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddMemoScreen()));
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                //TODO: 기념일 추가 위젯 List.generate
                ValueListenableBuilder(
                  valueListenable: Hive.box<Memo>('memo').listenable(),
                  builder: (context, Box<Memo> box, child) {
                    return Column(
                      children:  List.generate(
                              box.length,
                              (index) {
                                print(index);
                                final memo = box.getAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MemoScreen(memo: memo!),
                                      ),
                                    );
                                  },
                                  child: MemoCard(
                                    memo: memo!,
                                  ),
                                );
                              },
                            )
                    );
                  },
                ),
              ],
            ),
          ),
        ],
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

  Widget _dayCount(context, ref, selectedDate, Text day) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              await pickAvatarImage();
              selectImage();
            },
            child: Image.asset(
              'assets/img/smile.png',
              height: 80,
            ),
          ),
          Column(
            children: [
              IconButton(
                iconSize: 55,
                onPressed: () {
                  onHearthPressed(context, ref, selectedDate);
                },
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: const Icon(
                  Icons.favorite,
                  color: ColorPalette.point,
                ),
              ),
              day,
              // Text(
              //   '${DateTime(
              //     now.year,
              //     now.month,
              //     now.day,
              //   ).difference(selectedDate).inDays + 1}',
              //   style: Kangwon.black_s35_w400_h24,
              // ),
              // Text(
              //   '${DateTime(
              //     now.year,
              //     now.month,
              //     now.day,
              //   ).difference(ref.watch(dateProvider.state).state).inDays + 1}',
              //   style: Kangwon.black_s35_w400_h24,
              // ),
              // Text(
              //   '${DateTime(
              //     now.year,
              //     now.month,
              //     now.day,
              //   ).difference(item.selectedDate as DateTime).inDays + 1}',
              //   style: Kangwon.black_s35_w400_h24,
              // ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              await pickAvatarImage();
            },
            child: Image.asset(
              'assets/img/smile.png',
              height: 80,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
      cropImage(pickedFile: pickedFile);
    }
  }
}
