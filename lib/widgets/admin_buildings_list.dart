import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/admin_buildings_card.dart';

class AdminBuildingsList extends StatefulWidget {
  AdminBuildingsList({Key key}) : super(key: key);

  @override
  _AdminBuildingsListState createState() => _AdminBuildingsListState();
}

class _AdminBuildingsListState extends State<AdminBuildingsList> {
  GlobalKey<ScrollSnapListState> sslKeyAdminBuildings = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<AdminBuildingsBloc>(context).add(AdminBuildingsRequested());

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child: BlocBuilder<AdminBuildingsBloc, AdminBuildingsState>(
              builder: (context, state) {
                if (state is AdminBuildingsLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is AdminBuildingsLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 300,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.admin_buildings.length
                          ? Text("Bottom Loader")
                          : AdminBuildingCard(
                              height: 200,
                              width: 300,
                              name: state.admin_buildings[index].name,
                              fullDescription:
                                  state.admin_buildings[index].fullDescription,
                              featureImage: apiUrl +
                                  state.admin_buildings[index]
                                      .featuredImage["url"],
                            );
                    },
                    itemCount: state.admin_buildings.length,
                    key: sslKeyAdminBuildings,
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
