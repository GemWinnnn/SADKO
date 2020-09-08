import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/campuses/campuses_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/campus_card.dart';

class CampusesList extends StatefulWidget {
  CampusesList({Key key}) : super(key: key);

  @override
  _CampusesListState createState() => _CampusesListState();
}

class _CampusesListState extends State<CampusesList> {
  GlobalKey<ScrollSnapListState> sslKeyCampuses = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<CampusesBloc>(context).add(CampusesRequested());

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child: BlocBuilder<CampusesBloc, CampusesState>(
              builder: (context, state) {
                if (state is CampusesLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CampusesLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 300,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.campuses.length
                          ? Text("Bottom Loader")
                          : CampusCard(
                              height: 200,
                              width: 300,
                              name: state.campuses[index].name,
                              fullDescription:
                                  state.campuses[index].fullDescription,
                              shortDescription:
                                  state.campuses[index].shortDescription,
                              featuredImage: apiUrl +
                                  state.campuses[index].featuredImage["url"],
                              logo: apiUrl + state.campuses[index].logo["url"],
                            );
                    },
                    itemCount: state.campuses.length,
                    key: sslKeyCampuses,
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
