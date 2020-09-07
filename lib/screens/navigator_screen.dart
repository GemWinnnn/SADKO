import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/widgets/app_brand_horizontal.dart';
import 'package:wvsu_tour_app/config/app.dart';

class NavigatorScreen extends StatefulWidget {
  NavigatorScreen({Key key}) : super(key: key);

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  List<int> data = [];
  int _focusedIndex = 0;
  GlobalKey<ScrollSnapListState> sslKeyCampus = GlobalKey();
  GlobalKey<ScrollSnapListState> sslKeyAdmin = GlobalKey();
  GlobalKey<ScrollSnapListState> sslKeyOrganizations = GlobalKey();
  GlobalKey<ScrollSnapListState> sslKeyLandmarksSymbols = GlobalKey();
  GlobalKey<ScrollSnapListState> sslKeyStaff = GlobalKey();
  GlobalKey<ScrollSnapListState> sslKeyAcad = GlobalKey();

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent));

    for (int i = 0; i < 30; i++) {
      data.add(Random().nextInt(100) + 1);
    }

    _scrollController = ScrollController();

    // print(_focusedIndex);
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 200,
      decoration: BoxDecoration(
          boxShadow: appDefaultShadow,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: InkWell(
          onTap: () {
            sslKeyCampus.currentState.focusToItem(index);
          },
          child: Stack(
            children: [
              Positioned(
                bottom: 20,
                left: 20,
                child: Text("Data Here", style: appBodyTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo is UserScrollNotification) {
          if (scrollInfo.direction == ScrollDirection.forward) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent));
          } else if (scrollInfo.direction == ScrollDirection.reverse) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: appSecondaryColor));
          }
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          decoration: BoxDecoration(
              color: appSecondaryColor,
              image: DecorationImage(
                  alignment: Alignment.topRight,
                  image: AssetImage('assets/images/home-screen-top.png'))),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(appDefaultPadding,
                          appScreenSize.height * 0.07, appDefaultPadding, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Campus Tour",
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 30)),
                          Text(
                            "Hold thy banner high!",
                            style: GoogleFonts.lato(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: appScreenSize.height * 0.19),
                  child: Container(
                    decoration: BoxDecoration(
                        color: appPrimaryColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(36))),
                    width: appScreenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                          child: Text(
                            "Explore",
                            style: appSecondaryTitleTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ScrollSnapList(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            onItemFocus: _onItemFocus,
                            itemSize: 360,
                            itemBuilder: _buildListItem,
                            itemCount: data.length,
                            key: sslKeyCampus,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text("Academic Buildings",
                              style: appSecondaryTitleTextStyle),
                        ),
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ScrollSnapList(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            onItemFocus: _onItemFocus,
                            itemSize: 360,
                            itemBuilder: _buildListItem,
                            itemCount: data.length,
                            key: sslKeyAcad,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            "Admin Buildings",
                            style: appSecondaryTitleTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ScrollSnapList(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            onItemFocus: _onItemFocus,
                            itemSize: 360,
                            itemBuilder: _buildListItem,
                            itemCount: data.length,
                            key: sslKeyAdmin,
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
