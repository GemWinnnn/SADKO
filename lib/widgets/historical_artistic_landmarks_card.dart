import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/screens/photo_viewer.dart';

class HistoricalArtisticLandmarksCard extends StatelessWidget {
  const HistoricalArtisticLandmarksCard({
    Key key,
    this.featureImage,
    this.height,
    this.name,
    this.width,
  }) : super(key: key);
  final String name;
  final double height;
  final double width;
  final String featureImage;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: appDefaultBorderRadius,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: this.width,
            height: this.height,
            decoration: BoxDecoration(
              boxShadow: appDefaultShadow,
              color: Colors.white,
              borderRadius: appDefaultBorderRadius,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoViewer(
                        description: this.name,
                        image: this.featureImage,
                      ),
                    ));
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: appDefaultBorderRadius,
                    child: Container(
                      decoration: BoxDecoration(color: appPrimaryColor),
                      height: this.height + 10,
                      width: this.width,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Center(
                            child: ExtendedImage.network(
                          this.featureImage,
                          fit: BoxFit.fill,
                          cache: true,
                          border: Border.all(color: Colors.red, width: 1.0),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: this.height + 10,
                    width: this.width,
                    child: Opacity(
                      opacity: 0.3,
                      child: Container(
                          decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: appDefaultBorderRadius,
                      )),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 20,
                      child: Row(children: [
                        Icon(SimpleLineIcons.picture,
                            color: Colors.white, size: 15),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                              this.name != null ? this.name : "Loading...",
                              style: GoogleFonts.lato(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true),
                        )
                      ]))
                ],
              ),
            )));
  }
}
