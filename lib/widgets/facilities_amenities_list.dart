import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:wvsu_tour_app/bloc/blocs.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/widgets/academic_buildings_card.dart';
import 'package:wvsu_tour_app/widgets/facilities_amenities_card.dart';

class FacilitiesAmenitiesList extends StatefulWidget {
  FacilitiesAmenitiesList({Key key}) : super(key: key);

  @override
  _FacilitiesAmenitiesListState createState() =>
      _FacilitiesAmenitiesListState();
}

class _FacilitiesAmenitiesListState extends State<FacilitiesAmenitiesList> {
  GlobalKey<ScrollSnapListState> sslKeyFacilitiesAmenities = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size appScreenSize = MediaQuery.of(context).size;

    BlocProvider.of<FacilitiesAmenitiesBloc>(context)
        .add(FacilitiesAmenitiesRequested());

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child:
                BlocBuilder<FacilitiesAmenitiesBloc, FacilitiesAmenitiesState>(
              builder: (context, state) {
                if (state is FacilitiesAmenitiesLoadInProgress) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is FacilitiesAmenitiesLoadSuccess) {
                  return ScrollSnapList(
                    onItemFocus: (item) {
                      print(item);
                    },
                    initialIndex: 0,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    itemSize: 300,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.facilitiesAmenities.length
                          ? Text("Bottom Loader")
                          : FaciltlitiesAmenitiesCard(
                              height: 200,
                              width: 300,
                              shortDescription: state
                                  .facilitiesAmenities[index].shortDescription,
                              name: state.facilitiesAmenities[index].name,
                              featureImage: apiUrl +
                                  state.facilitiesAmenities[index]
                                      .featuredImage["url"],
                            );
                    },
                    itemCount: state.facilitiesAmenities.length,
                    key: sslKeyFacilitiesAmenities,
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
