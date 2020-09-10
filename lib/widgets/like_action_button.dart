import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LikeActionButton extends StatefulWidget {
  LikeActionButton({Key key, this.snapshotID}) : super(key: key);
  final String snapshotID;
  @override
  _LikeActionButtonState createState() => _LikeActionButtonState();
}

class _LikeActionButtonState extends State<LikeActionButton> {
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

    Future<void> addLike(FirebaseAuth auth) {
      collection
          .doc(auth.currentUser.uid)
          .set({'liked': true})
          .then((value) => print("Liked"))
          .catchError((error) => print("Failed like: $error"));
    }

    Future<void> removeLike(FirebaseAuth auth) {
      collection.doc(auth.currentUser.uid).delete();
    }

    return StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }

          if (snapshot.hasData) {
            doc.then((value) {
              if (value.exists) {
                if (this.mounted) {
                  this.setState(() {
                    _likeIcon = Icons.favorite;
                  });
                }
              } else {
                if (this.mounted) {
                  this.setState(() {
                    _likeIcon = Icons.favorite_outline;
                  });
                }
              }
            });
          }
          return new IconButton(
              icon: Icon(
                _likeIcon,
                color: Color(0xFF666666),
              ),
              onPressed: () {
                if (_likeIcon == Icons.favorite) {
                  removeLike(auth);
                } else {
                  addLike(auth);
                }
              });
        });
  }
}
