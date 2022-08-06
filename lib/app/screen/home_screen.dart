import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/provider/counter_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final valueProvider = Provider<int>((ref) {
    return 36;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.pink,
        elevation: 0,
        title: const Text('너랑 나', style: Kangwon.white_s30_bold_h24),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.watch(counterProvider.state).state++,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Text(
                  '커플',
                  style: Kangwon.point_s25_w400_h24,
                ),
                eWidth(10),
                Text(
                  '스토리',
                  style: Kangwon.point_s25_w400_h24,
                ),
              ],
            ),
          ),
          _backgroundImage(context),
          Container(
            child: Consumer(
              builder: (context, ref, _) {
                final int count = ref.watch(counterProvider.state).state;
                return Text('$count');
              },
            ),
          ),
          IconButton(
            iconSize: 68,
            onPressed: () {},
            icon: Icon(Icons.favorite,color: ColorPalette.lightPink,),
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
}
