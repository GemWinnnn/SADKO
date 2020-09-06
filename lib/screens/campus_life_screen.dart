import 'dart:math';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/config/app.dart';

class CampusLifeScreen extends StatefulWidget {
  CampusLifeScreen({Key key}) : super(key: key);

  @override
  _CampusLifeScreenState createState() => _CampusLifeScreenState();
}

class _CampusLifeScreenState extends State<CampusLifeScreen> {
  List<int> data = [];
  int _focusedIndex = 0;
  GlobalKey<ScrollSnapListState> sslKeyMessages = GlobalKey();
  GlobalKey<ScrollSnapListState> sslKeyOrgs = GlobalKey();
  GlobalKey<ScrollSnapListState> sslKeyPhotos = GlobalKey();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      data.add(Random().nextInt(100) + 1);
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 300,
      child: Material(
        borderRadius: appDefaultBorderRadius,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            sslKeyMessages.currentState.focusToItem(index);
          },
          child: Stack(
            children: [
              Positioned(
                bottom: 20,
                left: 20,
                child: Text("Name Here", style: GoogleFonts.openSans()),
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
    return SingleChildScrollView(
      controller: ScrollController(initialScrollOffset: 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: appPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(appDefaultPadding,
                  appScreenSize.height * 0.07, appDefaultPadding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Campus Life",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 30)),
                  Text(
                    'What it feels to be a "Taga-West"',
                    style: GoogleFonts.openSans(color: Colors.white),
                  )
                ],
              ),
            ),
            Divider(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Take a Way Messages",
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 20),
                )),
            SizedBox(
              height: appScreenSize.height * 0.5,
              width: double.infinity,
              child: ScrollSnapList(
                initialIndex: 0,
                margin: EdgeInsets.symmetric(vertical: 10),
                onItemFocus: _onItemFocus,
                itemSize: 300,
                itemBuilder: _buildListItem,
                itemCount: data.length,
                key: sslKeyMessages,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Our University president and other key officials would like to express their thoughts.",
                  style: GoogleFonts.openSans(color: Colors.white),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Organizations",
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 20),
                )),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ScrollSnapList(
                initialIndex: 0,
                margin: EdgeInsets.symmetric(vertical: 10),
                onItemFocus: _onItemFocus,
                itemSize: 300,
                itemBuilder: _buildListItem,
                itemCount: data.length,
                key: sslKeyOrgs,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Photos",
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 20),
                )),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ScrollSnapList(
                initialIndex: 0,
                margin: EdgeInsets.symmetric(vertical: 10),
                onItemFocus: _onItemFocus,
                itemSize: 300,
                itemBuilder: _buildListItem,
                itemCount: data.length,
                key: sslKeyPhotos,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Veggies es bonus vobis, proinde vos postulo essum magis kohlrabi welsh onion daikon amaranth tatsoi tomatillo melon azuki bean garlic.",
                  style: GoogleFonts.openSans(color: Colors.white),
                )),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
