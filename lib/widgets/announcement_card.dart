import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/screens/announcement_details_screen.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard(
      {Key key, this.title, this.featuredImage, this.contents, this.createdBy})
      : super(key: key);
  final String title;
  final dynamic featuredImage;
  final String contents;
  final dynamic createdBy;
  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;
    dynamic featuredImageThumbnail =
        apiUrl + (this.featuredImage["formats"]["thumbnail"]["url"] ?? "");
    dynamic featuredImage = apiUrl + this.featuredImage["url"];

    // https://python.developreference.com/article/11038302/Converting+DateTime+to+time+ago+in+Dart+Flutter
    String timeAgo(DateTime d) {
      Duration diff = DateTime.now().difference(d);
      if (diff.inDays > 365)
        return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
      if (diff.inDays > 30)
        return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
      if (diff.inDays > 7)
        return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
      if (diff.inDays > 0)
        return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
      if (diff.inHours > 0)
        return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
      if (diff.inMinutes > 0)
        return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
      return "just now";
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnnouncementDetailsScreen(
                contents: this.contents,
                title: this.title,
                featuredImage: featuredImage,
              ),
            ));
      },
      child: Container(
          child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: appScreenSize.width,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: appDefaultShadow,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Container(
                              decoration: BoxDecoration(color: appPrimaryColor),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  imageUrl: featuredImageThumbnail,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                  this.title != null
                                      ? this.title
                                      : "Loading...",
                                  style: appBodyTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true),
                            ),
                            SizedBox(height: 5),
                            Opacity(
                                opacity: 0.7,
                                child: Container(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    this.contents != null
                                        ? this.contents
                                        : "Loading...",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                )),
                            Divider(),
                            Opacity(
                                opacity: 0.5,
                                child: Container(
                                  width: appScreenSize.width -
                                      appScreenSize.width * 0.3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(Feather.feather, size: 15),
                                        Text(" " + this.createdBy),
                                      ]),
                                    ],
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}
