import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    dynamic featuredImage =
        apiUrl + this.featuredImage["formats"]["thumbnail"]["url"];
    return Container(
        child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: appScreenSize.width,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(featuredImage),
                                  fit: BoxFit.cover),
                              color: appPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                                this.title != null ? this.title : "Loading...",
                                style: GoogleFonts.openSans(
                                    color: Color(0xFF000000), fontSize: 18),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              this.contents != null
                                  ? this.contents
                                  : "Loading...",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                          Divider(),
                          Container(
                            width:
                                appScreenSize.width - appScreenSize.width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("by " + this.createdBy['firstname']),
                                Row(
                                  children: [
                                    Icon(
                                      SimpleLineIcons.clock,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(timeago.format(DateTime.parse(
                                        this.createdBy["createdAt"])))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
