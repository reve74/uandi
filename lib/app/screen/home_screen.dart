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
            child: Text(
              '커플',
              style: Kangwon.point_s25_w400_h24,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
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
      height: 600,
      child: TabBarView(
        controller: _tabController,
        children: [
          CoupleTabBar(),
          StoryTabBar(),
        ],
      ),
    );
  }
}
