import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/screens/photo_viewer.dart';

class CampusLifePhotoCardCard extends StatelessWidget {
  const CampusLifePhotoCardCard(
      {Key key,
      this.shortDescription,
      this.image,
      this.onPressed,
      this.height,
      this.width})
      : super(key: key);

  final GestureTapCallback onPressed;
  final double height;
  final double width;
  final String image;
  final String shortDescription;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: appDefaultBorderRadius,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        description: this.shortDescription,
                        image: this.image,
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
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Center(
                            child: CachedNetworkImage(
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                imageUrl: this.image,
                                fit: BoxFit.cover,
                                width: this.width + 50,
                                height: this.height)),
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
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                            this.shortDescription != null
                                ? this.shortDescription
                                : "Loading...",
                            style: GoogleFonts.lato(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true),
                      )),
                ],
              ),
            )));
  }
}
