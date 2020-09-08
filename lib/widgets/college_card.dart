import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/screens/college_details.dart';

class CollegeCard extends StatelessWidget {
  const CollegeCard(
      {Key key,
      this.shortDescription,
      this.longDescription,
      this.name,
      this.logo,
      this.campus,
      this.featuredImage,
      this.height,
      this.photos,
      this.width})
      : super(key: key);

  final double height;
  final double width;
  final String logo;
  final String name;
  final List<dynamic> photos;
  final String campus;
  final String longDescription;
  final String shortDescription;
  final String featuredImage;
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
                      builder: (context) => CollegeDetailsScreen(
                        longDescription: this.longDescription,
                        name: this.name,
                        logo: this.logo,
                        featuredImage: featuredImage,
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
                                imageUrl: this.featuredImage,
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
                  Container(
                    width: this.width,
                    height: this.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProfileAvatar(
                          this.logo,
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
                  Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                            this.name != null ? this.name : "Loading...",
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
