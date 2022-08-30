import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uandi/app/const/color_palette.dart';
import 'package:uandi/app/const/kangwon.dart';
import 'package:uandi/app/const/size_helper.dart';
import 'package:uandi/app/provider/counter_provider.dart';
import 'package:uandi/app/utils/util.dart';
import 'package:uandi/app/widget/couple_tabbar.dart';
import 'package:uandi/app/widget/story_tabbar.dart';
import 'package:uandi/app/widget/tabbar_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  // final valueProvider = Provider<int>((ref) {
  //   return 36;
  // });

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * .7,
        child: _drawer(),
      ),
      appBar: AppBar(
          backgroundColor: ColorPalette.pink,
          elevation: 0,
          title: const Text('너랑 나', style: Kangwon.white_s30_bold_h24),
          centerTitle: false,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.settings,
                  ),
                );
              },
            )
          ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => ref.watch(counterProvider.state).state++,
      //   child: const Icon(Icons.add),
      // ),
      body: Column(
        children: [
          _tabMenu(_tabController),
          _tabView(),
        ],
      ),
    );
  }

  Widget _tabMenu(_tabController) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        indicatorColor: ColorPalette.point,
        indicatorWeight: 1.5,
        controller: _tabController,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              '커플',
              style: Kangwon.point_s25_w400_h24,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              '스토리',
              style: Kangwon.point_s25_w400_h24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabView() {
    return Container(
      width: double.maxFinite,
      height: 650,
      child: TabBarView(
        controller: _tabController,
        children: [
          const CoupleTabBar(),
          const StoryTabBar(),
        ],
      ),
    );
  }

  Widget _drawerBtn({required String text, required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: Kangwon.black_s20_w400_h24,
          ),
        ),
      ),
    );
  }

  Widget _drawer() {
    DateTime selectedDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: ColorPalette.pink,
        ),
        Container(
          height: AppBar().preferredSize.height,
          color: ColorPalette.pink,
          child: const Center(
              child: Text(
            '설정',
            style: Kangwon.white_s30_bold_h24,
          )),
        ),
        const Spacer(flex: 10),
        _drawerBtn(
          onTap: () {
            Navigator.pop(context);
            onHearthPressed(context, ref, selectedDate);
          },
          text: '날짜 변경하기',
        ),
        _divider(),
        _drawerBtn(
          onTap: () {},
          text: '배경화면 변경하기',
        ),
        _divider(),
        // _drawerBtn(
        //   onTap: () {},
        //   text: '날짜 변경하기',
        // ),
        const Spacer(flex: 500),
      ],
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.0),
      child: Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }
}
