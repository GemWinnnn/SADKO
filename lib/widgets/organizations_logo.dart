import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';

class OrganizationsLogo extends StatelessWidget {
  const OrganizationsLogo(
      {Key key,
      this.name,
      this.logo,
      this.description,
      this.height,
      this.width})
      : super(key: key);

  final double height;
  final double width;
  final String logo;
  final String description;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProfileAvatar(
            this.logo,
            radius: 60,
            backgroundColor: Colors.grey[200],
            borderWidth: 10,
            borderColor: Colors.grey[200],
            cacheImage: true,
            onTap: () {
              print('img');
            }, // sets on tap
            showInitialTextAbovePicture:
                true, // setting it true will show initials text above profile picture, default false
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: this.width - 20,
            child: Column(
              children: [
                Text(
                  this.name != null ? this.name : "Loading...",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}