import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/campus_life/campus_life_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/campus_life_photo_card.dart';

class CampusLifeList extends StatefulWidget {
  CampusLifeList({Key key}) : super(key: key);

  @override
  _CampusLifeListState createState() => _CampusLifeListState();
}

class _CampusLifeListState extends State<CampusLifeList> {
  GlobalKey<ScrollSnapListState> sslKeyCampusLife = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<CampusLifeBloc>(context).add(CampusLifeRequested());

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child: BlocBuilder<CampusLifeBloc, CampusLifeState>(
              builder: (context, state) {
                if (state is CampusLifeLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is CampusLifeLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 300,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.campus_life.length
                          ? Text("Bottom Loader")
                          : CampusLifePhotoCardCard(
                              height: 200,
                              width: 300,
                              shortDescription:
                                  state.campus_life[index].shortDescription,
                              image: apiUrl +
                                  state.campus_life[index].image["url"],
                            );
                    },
                    itemCount: state.campus_life.length,
                    key: sslKeyCampusLife,
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
