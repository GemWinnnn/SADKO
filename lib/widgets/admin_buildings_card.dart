import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';

class AdminBuildingCard extends StatelessWidget {
  const AdminBuildingCard(
      {Key key, this.featureImage, this.height, this.name, this.width})
      : super(key: key);

  final String name;
  final double height;
  final double width;
  final String featureImage;
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
              onTap: () {},
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
                                imageUrl: this.featureImage ?? "",
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
                        child: Text(this.name ?? "Loading...",
                            style: GoogleFonts.lato(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true),
                      )),
                ],
              ),
            )));
  }
}
