import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/markdown_generator.dart';
import 'package:wvsu_tour_app/config/app.dart';

class CollegeDetailsScreen extends StatelessWidget {
  const CollegeDetailsScreen(
      {Key key, this.name, this.featuredImage, this.longDescription, this.logo})
      : super(key: key);
  final String name;
  final dynamic featuredImage;
  final String longDescription;
  final String logo;

  @override
  Widget build(BuildContext context) {
    Widget buildMarkdown() => Column(
          children: MarkdownGenerator(data: this.longDescription).widgets,
        );
    Size appScreenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "College",
            style: GoogleFonts.lato(color: Colors.black),
          ),
          elevation: 1,
          leading: IconButton(
              icon: Icon(
                Feather.chevron_left,
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
              Container(
                width: appScreenSize.width,
                height: appScreenSize.height * 0.33,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProfileAvatar(
                      this.logo ?? "",
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      borderWidth: 10,
                      borderColor: Colors.transparent,
                      cacheImage: true,
                      onTap: () {
                        print('img');
                      }, // sets on tap
                      showInitialTextAbovePicture:
                          true, // setting it true will show initials text above profile picture, default false
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(appDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: appDefaultBorderRadius,
                ),
                margin: EdgeInsets.only(top: appScreenSize.height * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.name,
                      style: appSecondaryTitleTextStyle,
                    ),
                    SizedBox(height: 10),
                    buildMarkdown()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
