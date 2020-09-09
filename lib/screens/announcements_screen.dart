import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/announcement_card.dart';

class AnnouncementsScreen extends StatefulWidget {
  AnnouncementsScreen({Key key}) : super(key: key);
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  Completer<void> _refreshCompleter;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;
    CollectionReference collection =
        FirebaseFirestore.instance.collection('announcements');

    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is UserScrollNotification) {
              if (scrollInfo.direction == ScrollDirection.forward) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.transparent));
                // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
              } else if (scrollInfo.direction == ScrollDirection.reverse) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white));
                // SystemChrome.setEnabledSystemUIOverlays([]);
              }
            }
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: appPrimaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, appScreenSize.height * 0.07, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: appDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Announcements", style: appTitleTextStyle),
                                SizedBox(height: 10),
                                Text(
                                  'Be informed!',
                                  style: appBodyTextStyle,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: collection.snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("An error occured.");
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: double.infinity,
                                      child: Column(
                                        children: [CircularProgressIndicator()],
                                      ),
                                    );
                                  }

                                  return Column(
                                      children: snapshot.data.docs
                                          .map((e) => AnnouncementCard(
                                                contents: e.data()['Contents'],
                                                featuredImage:
                                                    e.data()['FeaturedImage'],
                                                title: e.data()['Title'],
                                                createdBy:
                                                    e.data()['created_by'],
                                              ))
                                          .toList());
                                }))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
