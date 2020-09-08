import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/volunteers/volunteers_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/volunteer_avatar.dart';

class VolunteersList extends StatefulWidget {
  VolunteersList({Key key}) : super(key: key);

  @override
  _VolunteersListState createState() => _VolunteersListState();
}

class _VolunteersListState extends State<VolunteersList> {
  GlobalKey<ScrollSnapListState> sslKeyVolunteers = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<VolunteersBloc>(context).add(VolunteersRequested());

    return Container(
        child: SizedBox(
            height: 150,
            width: double.infinity,
            child: BlocBuilder<VolunteersBloc, VolunteersState>(
              builder: (context, state) {
                if (state is VolunteersLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is VolunteersLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 400,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.volunteers.length
                          ? Text("Bottom Loader")
                          : VolunteersAvatar(
                              height: 100,
                              width: 110,
                              name: state.volunteers[index].name,
                              description: state.volunteers[index].description,
                              profileImage: apiUrl +
                                  state.volunteers[index].profileImage["url"],
                            );
                    },
                    itemCount: state.volunteers.length,
                    key: sslKeyVolunteers,
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
