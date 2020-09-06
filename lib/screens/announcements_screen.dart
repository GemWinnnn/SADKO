import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;
    BlocProvider.of<AnnouncementsBloc>(context).add(AnnouncementsRequested());
    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: SingleChildScrollView(
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
                      Text("Announcements",
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 30)),
                      Text(
                        'Be informed!',
                        style: GoogleFonts.openSans(color: Colors.white),
                      ),
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

                          return Center(
                            child: Text(
                              "No connection :(",
                              style: GoogleFonts.openSans(color: Colors.white),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
