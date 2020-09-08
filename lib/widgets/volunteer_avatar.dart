import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class VolunteersAvatar extends StatelessWidget {
  const VolunteersAvatar(
      {Key key,
      this.name,
      this.profileImage,
      this.description,
      this.height,
      this.width})
      : super(key: key);

  final double height;
  final double width;
  final String profileImage;
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
            this.profileImage ?? "",
            radius: 50,
            backgroundColor: Colors.grey[200],
            borderWidth: 10,
            borderColor: Colors.transparent,
            cacheImage: true,
            onTap: () {
              // TODO: Alert here
              print('img');
            }, // sets on tap
            showInitialTextAbovePicture:
                true, // setting it true will show initials text above profile picture, default false
          ),
        ],
      ),
    );
  }
}
