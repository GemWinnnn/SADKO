import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/academic_buildings_card.dart';

class AcademicBuildingsList extends StatefulWidget {
  AcademicBuildingsList({Key key}) : super(key: key);

  @override
  _AcademicBuildingsListState createState() => _AcademicBuildingsListState();
}

class _AcademicBuildingsListState extends State<AcademicBuildingsList> {
  GlobalKey<ScrollSnapListState> sslKeyAcademicBuildings = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<AcademicBuildingsBloc>(context)
        .add(AcademicBuildingsRequested());

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child: BlocBuilder<AcademicBuildingsBloc, AcademicBuildingsState>(
              builder: (context, state) {
                if (state is AcademicBuildingsLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is AcademicBuildingsLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 380,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.academic_buildings.length
                          ? Text("Bottom Loader")
                          : AcademicBuildingCard(
                              height: 200,
                              width: 300,
                              longDescription: state
                                  .academic_buildings[index].longDescription,
                              name: state.academic_buildings[index].name,
                              featureImage: apiUrl +
                                  state.academic_buildings[index]
                                      .featuredImage["url"],
                            );
                    },
                    itemCount: state.academic_buildings.length,
                    key: sslKeyAcademicBuildings,
                  );
                }

                return Container(
                    width: appScreenSize.width,
                    height: appScreenSize.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ));
              },
            )));
  }
}
