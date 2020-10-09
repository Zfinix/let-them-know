import 'package:call_them_app/core/provider_registery.dart';
import 'package:call_them_app/core/viewmodels/menu_vm.dart';
import 'package:call_them_app/utils/margin.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MenuPage extends StatefulHookWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  MenuViewModel get vm => context.read(menuVM);

  TabController tabController;
  @override
  void initState() {
    setState(() {
      tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var menuList = useProvider(menuVM.select((v) => v.menuList));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            YMargin(10),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  XMargin(40),
                  Text(
                      "${tabController.index == 0 ? 'Home' : tabController.index == 1 ? 'Directory' : tabController.index == 2 ? 'Feedback' : ''}"
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.greenAccent[700],
                          fontWeight: FontWeight.w700))
                ],
              ),
            ),
            YMargin(10),
            Divider(),
            Flexible(
              child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: menuList,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              offset: Offset(0, 10),
              color: Colors.grey[400].withOpacity(0.5),
              blurRadius: 25,
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: tabController?.index ?? 0,
          onTap: (index) => setState(() => tabController.animateTo(index)),
          items: [
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.reciept_24_regular),
              title: Text("Home"),
              selectedColor: Colors.green,
            ),
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.list_24_regular),
              title: Text("Directory"),
              selectedColor: Colors.green,
            ),
            SalomonBottomBarItem(
              icon: Icon(FluentIcons.person_feedback_24_regular),
              title: Text("Feedback"),
              selectedColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
