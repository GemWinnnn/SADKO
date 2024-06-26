import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/markdown_generator.dart';
import 'package:wvsu_tour_app/config/app.dart';

class AcademicBuildingDetailsScreen extends StatelessWidget {
  const AcademicBuildingDetailsScreen(
      {Key key, this.name, this.featuredImage, this.longDescription})
      : super(key: key);
  final String name;
  final dynamic featuredImage;
  final String longDescription;

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
            "Academic Building",
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
                          image: ExtendedNetworkImageProvider(
                              this.featuredImage)))),
              Container(
                padding: EdgeInsets.all(appDefaultPadding),
                width: appScreenSize.width,
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
