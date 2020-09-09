import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeActionButton extends StatefulWidget {
  LikeActionButton({Key key, this.snapshotID}) : super(key: key);
  final String snapshotID;
  @override
  _LikeActionButtonState createState() => _LikeActionButtonState();
}

// TODO: Implement like counter
class _LikeActionButtonState extends State<LikeActionButton> {
  @override
  Widget build(BuildContext context) {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('likes_bucket')
        .doc(widget.snapshotID)
        .collection('likes');
    final FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return IconButton(
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.black,
                ),
                onPressed: () {});
          }
          if (snapshot.hasData) {}

          print(snapshot.data);
          // print(auth.currentUser.uid);
          return new IconButton(
              icon: Icon(
                Icons.favorite_outline,
                color: Colors.black,
              ),
              onPressed: () {
                // collection
                //     .doc('likes')
                //     .doc(auth.currentUser.uid)
                //     .set({'liked': true});
              });
        });
  }
}
