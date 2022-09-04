import 'package:flutter/material.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';

class AddAnniversaryScreen extends StatelessWidget {
  const AddAnniversaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('추가하기', style: Kangwon.white_s25_w400_h24),
                ),
                style: ElevatedButton.styleFrom(
                  primary: ColorPalette.pink,
                  elevation: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
