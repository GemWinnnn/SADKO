import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:wvsu_tour_app/firebase/auth.dart';
import 'package:wvsu_tour_app/models/models.dart';
import 'package:wvsu_tour_app/screens/about_screen.dart';
import 'package:wvsu_tour_app/screens/announcements_screen.dart';
import 'package:wvsu_tour_app/screens/campus_life_screen.dart';
import 'package:wvsu_tour_app/screens/navigator_screen.dart';
import 'package:wvsu_tour_app/screens/thankyou_frontliners_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth, this.announcements}) : super(key: key);

  final BaseAuth auth;
  final Announcements announcements;

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
    Auth appAuth = new Auth();
    return Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
        bottomNavigationBar: ConvexAppBar(
          color: Color(0xFF106DCF),
          backgroundColor: Colors.white,
          activeColor: Color(0xFF106DCF),
          controller: _tabController,
          elevation: 0,
          items: [
            TabItem(
              icon: SimpleLineIcons.bell,
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
            TabItem(icon: SimpleLineIcons.info),
          ],
          initialActiveIndex: 2, //optional, default as 0
          onTap: (int i) => print('click index=$i'),
        ),
        body: TabBarView(controller: _tabController, children: [
          new AnnouncementsScreen(contents: widget.announcements),
          new CampusLifeScreen(),
          new NavigatorScreen(),
          new ThankyouFrontlinersScreen(),
          new AboutScreen(auth: appAuth),
        ]));
  }
}
