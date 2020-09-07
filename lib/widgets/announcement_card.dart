import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:timeago/timeago.dart' as timeago;
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
        apiUrl + this.featuredImage["formats"]["thumbnail"]["url"];
    dynamic featuredImage = apiUrl + this.featuredImage["url"];
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
                                        Text(" " + this.createdBy['username']),
                                      ]),
                                      Row(
                                        children: [
                                          Icon(
                                            SimpleLineIcons.clock,
                                            size: 15,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          // Text(timeago.format(DateTime
                                          //     .fromMillisecondsSinceEpoch(DateTime
                                          //             .parse(this.createdBy[
                                          //                 "createdAt"])
                                          //         .add(Duration(
                                          //             milliseconds: new DateTime
                                          //                     .now()
                                          //                 .millisecondsSinceEpoch))
                                          //         .millisecondsSinceEpoch)))
                                          Text(timeago.format(DateTime.now()
                                              .subtract(Duration(
                                                  minutes: DateTime.parse(
                                                          this.createdBy[
                                                              "createdAt"])
                                                      .minute))))
                                        ],
                                      )
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
