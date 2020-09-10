import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/screens/announcement_details_screen.dart';
import 'package:wvsu_tour_app/widgets/like_counter.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard(
      {Key key,
      this.title,
      this.featuredImage,
      this.featuredImageThumb,
      this.contents,
      this.createdBy,
      this.id})
      : super(key: key);
  final String title;
  final String featuredImageThumb;
  final String featuredImage;
  final String contents;
  final dynamic createdBy;
  final String id;
  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    _ago(Timestamp t) {
      return timeago.format(new DateTime.now()
          .subtract(new Duration(minutes: t.toDate().minute)));
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnnouncementDetailsScreen(
                contents: this.contents,
                title: this.title,
                featuredImage: this.featuredImage,
                id: this.id,
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
                                  imageUrl: this.featuredImageThumb,
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
                                  style: GoogleFonts.lato(fontSize: 19),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true),
                            ),
                            SizedBox(height: 5),
                            Opacity(
                                opacity: 0.5,
                                child: Row(children: [
                                  Icon(Feather.feather, size: 15),
                                  SizedBox(width: 5),
                                  Text(this.createdBy['username'] != null
                                      ? this.createdBy['username']
                                      : '...'),
                                ])),
                            SizedBox(height: 10),
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
                            Container(
                              height: 2,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: appScreenSize.width * 0.7,
                              color: appPrimaryColor,
                            ),
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
                                        Icon(Icons.favorite, size: 15),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        LikeCounter(snapshotID: this.id),
                                      ]),
                                      Text(_ago(this.createdBy['createdAt']))
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
