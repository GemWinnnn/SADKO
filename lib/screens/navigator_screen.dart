import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/bloc/campuses/campuses_bloc.dart';
import 'package:wvsu_tour_app/bloc/colleges/colleges_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/repositories/academic_buildings/academic_buildings_api.dart';
import 'package:wvsu_tour_app/repositories/admin_buildings/admin_buildings_api.dart';
import 'package:wvsu_tour_app/repositories/campuses/campuses_api.dart';
import 'package:wvsu_tour_app/repositories/colleges/colleges_api.dart';
import 'package:wvsu_tour_app/repositories/facilities_amenities/facilities_amenities_api.dart';
import 'package:wvsu_tour_app/repositories/repositories.dart';
import 'package:wvsu_tour_app/widgets/academic_buildings_list.dart';
import 'package:wvsu_tour_app/widgets/admin_buildings_list.dart';
import 'package:wvsu_tour_app/widgets/campuses_list.dart';
import 'package:wvsu_tour_app/widgets/colleges_list.dart';
import 'package:wvsu_tour_app/widgets/facilities_amenities_list.dart';

class NavigatorScreen extends StatefulWidget {
  NavigatorScreen({Key key}) : super(key: key);

  final CampusesRepository campusesRepository = CampusesRepository(
    apiClient: CampusesApiClient(
      httpClient: http.Client(),
    ),
  );

  final CollegesRepository collegesRepository = CollegesRepository(
    apiClient: CollegesApiClient(
      httpClient: http.Client(),
    ),
  );

  final AcademicBuildingsRepository academicBuildingsRepository =
      AcademicBuildingsRepository(
    apiClient: AcademicBuildingsApiClient(
      httpClient: http.Client(),
    ),
  );

  final AdminBuildingsRepository adminBuildingsRepository =
      AdminBuildingsRepository(
    apiClient: AdminBuildingsApiClient(
      httpClient: http.Client(),
    ),
  );

  final FacilitiesAmenitiesRepository facilitiesAmenitiesRepository =
      FacilitiesAmenitiesRepository(
    apiClient: FacilitiesAmenitiesApiClient(
      httpClient: http.Client(),
    ),
  );

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  List<int> data = [];

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
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
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent));
            // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          } else if (scrollInfo.direction == ScrollDirection.reverse) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: appSecondaryColor));
          }
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          decoration: BoxDecoration(
              color: appSecondaryColor,
              image: DecorationImage(
                  alignment: Alignment.topRight,
                  image: AssetImage('assets/images/home-screen-top.png'))),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(appDefaultPadding,
                          appScreenSize.height * 0.07, appDefaultPadding, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Campus Tour",
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: 30)),
                          SizedBox(height: 10),
                          Text(
                            "From a dream, a University grew.",
                            style: GoogleFonts.lato(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: appScreenSize.height * 0.19),
                  child: Container(
                    decoration: BoxDecoration(
                        color: appPrimaryColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(36))),
                    width: appScreenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
                          child: Text(
                            "Campuses",
                            style: appSecondaryTitleTextStyle,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: Text(
                              "Main and External Campuses",
                              style: appBodyTextStyle,
                            )),
                        BlocProvider(
                          create: (context) => CampusesBloc(
                              campusesRepository: widget.campusesRepository),
                          child: new CampusesList(),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            "Colleges",
                            style: appSecondaryTitleTextStyle,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: Text(
                              "Different colleges offering diverse spectrum of courses.",
                              style: appBodyTextStyle,
                            )),
                        BlocProvider(
                          create: (context) => CollegesBloc(
                              collegesRepository: widget.collegesRepository),
                          child: new CollegesList(),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            "Academic Buildings",
                            style: appSecondaryTitleTextStyle,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: Text(
                              "Let wisdom set you free.",
                              style: appBodyTextStyle,
                            )),
                        BlocProvider(
                          create: (context) => AcademicBuildingsBloc(
                              academicBuildingsRepository:
                                  widget.academicBuildingsRepository),
                          child: new AcademicBuildingsList(),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            "Administrative Offices",
                            style: appSecondaryTitleTextStyle,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: Text(
                              "The administrative offices for effective and efficient University operations.",
                              style: appBodyTextStyle,
                            )),
                        BlocProvider(
                          create: (context) => AdminBuildingsBloc(
                              adminBuildingsRepository:
                                  widget.adminBuildingsRepository),
                          child: new AdminBuildingsList(),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            "Facilities and Amenities",
                            style: appSecondaryTitleTextStyle,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 0),
                            child: Text(
                              "Our University continues to expanded and improved her cultural and welfare facilities.",
                              style: appBodyTextStyle,
                            )),
                        BlocProvider(
                          create: (context) => FacilitiesAmenitiesBloc(
                              facilitiesAmenitiesRepository:
                                  widget.facilitiesAmenitiesRepository),
                          child: new FacilitiesAmenitiesList(),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
