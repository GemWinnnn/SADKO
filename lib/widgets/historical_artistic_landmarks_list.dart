import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/historical_artistic_landmarks_card.dart';

class HistoricalArtisticLandmarksList extends StatefulWidget {
  HistoricalArtisticLandmarksList({Key key}) : super(key: key);

  @override
  _HistoricalArtisticLandmarksListState createState() =>
      _HistoricalArtisticLandmarksListState();
}

class _HistoricalArtisticLandmarksListState
    extends State<HistoricalArtisticLandmarksList> {
  GlobalKey<ScrollSnapListState> sslKeyHistoricalArtisticLandmarks =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<HistoricalArtisticLandmarksBloc>(context)
        .add(HistoricalArtisticLandmarksRequested());

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child: BlocBuilder<HistoricalArtisticLandmarksBloc,
                HistoricalArtisticLandmarksState>(
              builder: (context, state) {
                if (state is HistoricalArtisticLandmarksLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is HistoricalArtisticLandmarksLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 300,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.historicalArtisticLandmarks.length
                          ? Text("Bottom Loader")
                          : HistoricalArtisticLandmarksCard(
                              height: 200,
                              width: 300,
                              name:
                                  state.historicalArtisticLandmarks[index].name,
                              featureImage: apiUrl +
                                  state.historicalArtisticLandmarks[index]
                                      .featuredImage["url"],
                            );
                    },
                    itemCount: state.historicalArtisticLandmarks.length,
                    key: sslKeyHistoricalArtisticLandmarks,
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
