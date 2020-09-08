import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/colleges/colleges_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/college_card.dart';

class CollegesList extends StatefulWidget {
  CollegesList({Key key}) : super(key: key);

  @override
  _CollegesListState createState() => _CollegesListState();
}

class _CollegesListState extends State<CollegesList> {
  GlobalKey<ScrollSnapListState> sslKeyColleges = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<CollegesBloc>(context).add(CollegesRequested());

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child: BlocBuilder<CollegesBloc, CollegesState>(
              builder: (context, state) {
                if (state is CollegesLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CollegesLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 300,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.colleges.length
                          ? Text("Bottom Loader")
                          : CollegeCard(
                              height: 200,
                              width: 300,
                              campus: state.colleges[index].campus,
                              photos: state.colleges[index].photos,
                              name: state.colleges[index].name,
                              longDescription:
                                  state.colleges[index].longDescription,
                              shortDescription:
                                  state.colleges[index].shortDescription,
                              featuredImage: apiUrl +
                                  state.colleges[index].featuredImage["url"],
                              logo: apiUrl + state.colleges[index].logo["url"],
                            );
                    },
                    itemCount: state.colleges.length,
                    key: sslKeyColleges,
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
