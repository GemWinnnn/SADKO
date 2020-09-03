import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:wvsu_tour_app/screens/announcements_screen.dart';
import 'package:wvsu_tour_app/screens/campus_life_screen.dart';
import 'package:wvsu_tour_app/screens/messages_screen.dart';
import 'package:wvsu_tour_app/screens/navigator_screen.dart';
import 'package:wvsu_tour_app/screens/thankyou_frontliners_screen.dart';

import '../config/app.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appScaffoldBackgroundColor,
        bottomNavigationBar: ConvexAppBar(
          color: appPrimaryColor,
          backgroundColor: Colors.white,
          activeColor: appPrimaryColor,
          controller: _tabController,
          items: [
            TabItem(
              icon: SimpleLineIcons.feed,
            ),
            TabItem(
              icon: SimpleLineIcons.graduation,
            ),
            TabItem(
              icon: SimpleLineIcons.cursor,
            ),
            TabItem(
              icon: SimpleLineIcons.heart,
            ),
            TabItem(
              icon: SimpleLineIcons.user,
            ),
          ],
          initialActiveIndex: 2,
          //optional, default as 0
          onTap: (int i) => print('click index=$i'),
        ),
        body: TabBarView(controller: _tabController, children: [
          new AnnouncementsScreen(),
          new MessagesScreen(),
          new NavigatorScreen(),
          new ThankyouFrontlinersScreen(),
          new CampusLifeScreen(),
        ]));
  }
}
