import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:wvsu_tour_app/bloc/volunteers/volunteers_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/firebase/auth.dart';
import 'package:wvsu_tour_app/repositories/volunteers/volunteers_api.dart';
import 'package:wvsu_tour_app/repositories/volunteers/volunteers_repository.dart';
import 'package:wvsu_tour_app/widgets/volunteers_list.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key, this.auth}) : super(key: key);
  BaseAuth auth;

  final VolunteersRepository volunteersRepository = VolunteersRepository(
    apiClient: VolunteersApiClient(
      httpClient: http.Client(),
    ),
  );
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _userPhotoUrl =
      "https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg";
  User _user;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    widget.auth.getCurrentUser().then((user) => {
          this.setState(() {
            _user = user;
            _userPhotoUrl = user.photoURL;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }

      _scrollController = ScrollController();
    }

    return Scaffold(
        backgroundColor: appPrimaryColor,
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is UserScrollNotification) {
              if (scrollInfo.direction == ScrollDirection.forward) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.transparent));
              } else if (scrollInfo.direction == ScrollDirection.reverse) {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white));
              }
            }
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: appPrimaryColor),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              appDefaultPadding,
                              appScreenSize.height * 0.07,
                              appDefaultPadding,
                              0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("About", style: appTitleTextStyle),
                              Text(
                                'Information about this app',
                                style: appBodyTextStyle,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                    ],
                  ),
                  Padding(
                      padding:
                          EdgeInsets.only(top: appScreenSize.height * 0.19),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: appDefaultShadow,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(36))),
                        width: appScreenSize.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                              child: Text("App User",
                                  style: appSecondaryTitleTextStyle),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: appDefaultPadding),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: SizedBox(
                                          height: 120,
                                          width: 50,
                                          child: CircularProfileAvatar(
                                            _userPhotoUrl,
                                            radius: 100,
                                            backgroundColor: Colors.grey[200],
                                            borderWidth: 10,
                                            borderColor: Colors.transparent,
                                            cacheImage: true,
                                            onTap: () {
                                              print('adil');
                                            }, // sets on tap
                                            showInitialTextAbovePicture:
                                                true, // setting it true will show initials text above profile picture, default false
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _user != null
                                                  ? _user.displayName
                                                  : "User Name",
                                              style: appBodyBoldTextStyle,
                                            ),
                                            Text(
                                              "Connected via " +
                                                  (_user != null
                                                      ? _user.providerData.first
                                                          .providerId
                                                      : "..."),
                                              style: appBodyTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: 10,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: IconButton(
                                            tooltip: "Logout",
                                            icon: Icon(Feather.log_out),
                                            onPressed: () {
                                              widget.auth.signOut();
                                            }),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2.0,
                              height: 30,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  child: WebsafeSvg.asset(
                                      "assets/icon/icon.svg",
                                      height: 90),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  child: Text(
                                    "WVSU Campus Tour",
                                    style: appSecondaryTitleTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  child: Text(
                                    "WVSU Campus Tour is a mobile app developed by the volunteers from the College of Information and Communications Technology, Main Campus. It aims to mitigate the effect of the pandemic for students who want to get more familiar with the University.",
                                    style: appBodyTextStyle,
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              thickness: 2,
                              height: 30,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Volunteers",
                                      style: appSecondaryTitleTextStyle,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "This app is not possible without the help of these WVSU volunteers.",
                                      style: appBodyTextStyle,
                                    ),
                                  ],
                                )),
                            BlocProvider(
                              create: (context) => VolunteersBloc(
                                  volunteersRepository:
                                      widget.volunteersRepository),
                              child: new VolunteersList(),
                            ),
                            Divider(
                              thickness: 2,
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                              child: Text(
                                "Open Source",
                                style: GoogleFonts.lato(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Column(
                                children: [
                                  Text(
                                      "WVSU Campus tour app is being developed publicly on GitHub. Anyone with or without the knowledge of programming can help with its development. Please report any suggestions or issues by pressing the button below.",
                                      style: appBodyTextStyle),
                                  SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton.icon(
                                        onPressed: () {
                                          _launchURL(
                                              "https://github.com/wvsu-cict-code/wvsu-tour-app/issues");
                                        },
                                        icon: Icon(FontAwesome.github),
                                        label: Text("Contribute")),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
