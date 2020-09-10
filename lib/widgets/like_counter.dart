import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wvsu_tour_app/config/app.dart';

class LikeCounter extends StatefulWidget {
  LikeCounter({Key key, this.id, this.color, this.fontSize}) : super(key: key);
  final String id;
  Color color;
  double fontSize;
  @override
  _LikeCounterState createState() => _LikeCounterState();
}

class _LikeCounterState extends State<LikeCounter> {
  IconData _likeIcon = Icons.favorite_outline;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('likes_bucket')
        .doc(widget.id)
        .collection('likes');
    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<DocumentSnapshot> doc = FirebaseFirestore.instance
        .collection('likes_bucket')
        .doc(widget.id)
        .collection('likes')
        .doc(auth.currentUser.uid)
        .get();

    return StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }

          if (snapshot.hasData) {
            return new Text(snapshot.data.docs.length.toString(),
                style: GoogleFonts.lato(
                    color:
                        widget.color != null ? widget.color : appTextBodyColor,
                    fontSize: widget.fontSize ?? 10));
          }
          return new Text(
            "0",
            style: GoogleFonts.lato(
                color: widget.color != null ? widget.color : appTextBodyColor,
                fontSize: widget.fontSize ?? 10),
          );
        });
  }
}
