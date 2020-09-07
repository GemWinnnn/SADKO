import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/bloc/campus_life/campus_life_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/repositories/campus_life/campus_life_api.dart';
import 'package:wvsu_tour_app/repositories/campus_life/campus_life_repository.dart';
import 'package:wvsu_tour_app/repositories/messages/messages_api.dart';
import 'package:wvsu_tour_app/repositories/messages/messages_repository.dart';
import 'package:wvsu_tour_app/widgets/campus_life_list.dart';
import 'package:wvsu_tour_app/widgets/messages_list.dart';

class CampusLifeScreen extends StatefulWidget {
  CampusLifeScreen({Key key}) : super(key: key);

  final MessagesRepository messagesRepository = MessagesRepository(
    apiClient: MessagesApiClient(
      httpClient: http.Client(),
    ),
  );

  final CampusLifeRepository campusLifeRepository = CampusLifeRepository(
    apiClient: CampusLifeApiClient(
      httpClient: http.Client(),
    ),
  );

  @override
  _CampusLifeScreenState createState() => _CampusLifeScreenState();
}

class _CampusLifeScreenState extends State<CampusLifeScreen> {
  ScrollController _scrollController;
  GlobalKey<ScrollSnapListState> sslKeyMessages = GlobalKey();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    return NotificationListener<ScrollNotification>(
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
            return true;
          } else {
            return false;
          }
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: appPrimaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(appDefaultPadding,
                      appScreenSize.height * 0.07, appDefaultPadding, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Campus Life", style: appTitleTextStyle),
                      Text(
                        'Taga-West - you belong!',
                        style: appBodyTextStyle,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text("Take a Way Messages",
                        style: appSecondaryTitleTextStyle)),
                BlocProvider(
                  create: (context) => MessagesBloc(
                      messagesRepository: widget.messagesRepository),
                  child: new MessagesList(),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      "Our University president and other key officials would like to express their thoughts.",
                      style: appBodyBoldTextStyle,
                    )),
                Divider(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text("Inside the Campus",
                        style: appSecondaryTitleTextStyle)),
                BlocProvider(
                  create: (context) => CampusLifeBloc(
                      campusLifeRepository: widget.campusLifeRepository),
                  child: new CampusLifeList(),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text("School Organizations",
                        style: appSecondaryTitleTextStyle)),
                BlocProvider(
                  create: (context) => CampusLifeBloc(
                      campusLifeRepository: widget.campusLifeRepository),
                  child: new CampusLifeList(),
                ),
              ],
            ),
          ),
        ));
  }
}
