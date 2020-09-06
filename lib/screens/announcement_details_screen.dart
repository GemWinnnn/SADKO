import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  const AnnouncementDetailsScreen(
      {Key key, this.title, this.featuredImage, this.contents})
      : super(key: key);
  final String title;
  final dynamic featuredImage;
  final String contents;
  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Announcement",
            style: GoogleFonts.lato(color: Colors.black),
          ),
          elevation: 1,
          leading: IconButton(
              icon: Icon(
                Feather.arrow_left,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              width: appScreenSize.width,
              height: appScreenSize.height * 0.33,
              decoration: BoxDecoration(
                  color: appPrimaryColor,
                  image: DecorationImage(
                      image: NetworkImage(this.featuredImage),
                      fit: BoxFit.cover)),
            ),
            Opacity(
                opacity: 0.2,
                child: Container(
                    height: appScreenSize.height * 0.4,
                    decoration: BoxDecoration(color: Colors.black))),
            Container(
              width: appScreenSize.width,
              margin: EdgeInsets.only(top: appScreenSize.height * 0.28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
              ),
              child: Padding(
                padding: EdgeInsets.all(appDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.title,
                      style: GoogleFonts.lato(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    Text(this.contents)
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
