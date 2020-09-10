import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/firebase/auth.dart';
import 'package:wvsu_tour_app/screens/about_screen.dart';
import 'package:wvsu_tour_app/screens/announcements_screen.dart';
import 'package:wvsu_tour_app/screens/campus_life_screen.dart';
import 'package:wvsu_tour_app/screens/navigator_screen.dart';
import 'package:wvsu_tour_app/screens/thankyou_frontliners_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth}) : super(key: key);

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
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
          elevation: 1,
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
          new AnnouncementsScreen(),
          new CampusLifeScreen(),
          new NavigatorScreen(),
          new ThankyouFrontlinersScreen(auth: appAuth),
          new AboutScreen(auth: appAuth),
        ]));
  }
}
