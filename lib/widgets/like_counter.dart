import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeCounter extends StatefulWidget {
  LikeCounter({Key key, this.snapshotID}) : super(key: key);
  final String snapshotID;
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
        .doc(widget.snapshotID)
        .collection('likes');
    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<DocumentSnapshot> doc = FirebaseFirestore.instance
        .collection('likes_bucket')
        .doc(widget.snapshotID)
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
            return new Text(snapshot.data.docs.length.toString());
          }
          return new Text("0");
        });
  }
}
