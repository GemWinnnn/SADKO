import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/components/announcement_card.dart';
import 'package:wvsu_tour_app/config/app.dart';

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
    BlocProvider.of<AnnouncementsBloc>(context).add(AnnouncementsRequested());
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is UserScrollNotification) {
              if (scrollInfo.direction == ScrollDirection.forward) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.transparent));
              } else if (scrollInfo.direction == ScrollDirection.reverse) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white));
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
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, appScreenSize.height * 0.07, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: appDefaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Announcements", style: appTitleTextStyle),
                                Text(
                                  'Be informed!',
                                  style: appBodyTextStyle,
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AnnouncementsBloc, AnnouncementsState>(
                          builder: (context, state) {
                            if (state is AnnouncementsLoadInProgress) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is AnnouncementsLoadSuccess) {
                              return Column(
                                children: state.announcements
                                    .map((e) => AnnouncementCard(
                                          contents: e.contents,
                                          featuredImage: e.featuredImage,
                                          title: e.title,
                                          createdBy: e.createdBy,
                                        ))
                                    .toList(),
                              );
                            }

                            return Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "No connection :(",
                                  style: GoogleFonts.lato(
                                      color: appTextPrimaryColor),
                                )
                              ],
                            ));
                          },
                        )
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
