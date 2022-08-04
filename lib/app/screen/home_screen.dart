import 'package:flutter/material.dart';
import 'package:uandi/app/const/color_palette.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.lightPink,
        elevation: 0,
        title: Text('U & I'),
      ),
      body: Center(
        child: Text('test'),
      ),
    );
  }
}
