import 'package:cloud_firestore/cloud_firestore.dart';
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

    CollectionReference collection =
        FirebaseFirestore.instance.collection('campus_life');

    return Container(
        child: SizedBox(
            height: 250,
            width: double.infinity,
            child: FutureBuilder<QuerySnapshot>(
                future: collection.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("An error occured.");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<QueryDocumentSnapshot> data = snapshot.data.docs;
                      return SingleChildScrollView(
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            Row(
                                children: data
                                    .map((e) => CampusLifePhotoCardCard(
                                          height: 200,
                                          width: 300,
                                          shortDescription:
                                              e.data()['Short Description'],
                                          image:
                                              apiUrl + e.data()['Image']['url'],
                                        ))
                                    .toList())
                          ],
                        ),
                      );
                    }
                  }
                  return Container(
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                })));
  }
}
