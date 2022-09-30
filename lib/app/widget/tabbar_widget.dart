import 'package:flutter/material.dart';
import 'package:uandi/app/const/kangwon.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _tabMenu(_tabController),
        _tabView(),
      ],
    );
  }

  Widget _tabMenu(_tabController) {
    return TabBar(
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      controller: _tabController,
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
          child:   const Text(
            '스토리',
            style: Kangwon.point_s25_w400_h24,
          ),
        ),
      ],
    );
  }

  Widget _tabView() {
    return SizedBox(
      width: double.maxFinite,
      height: 300,
      child: TabBarView(
        controller: _tabController,
        children: const [
          Text('커플'),
          Text('스토리'),
        ],
      ),
    );
  }
}
