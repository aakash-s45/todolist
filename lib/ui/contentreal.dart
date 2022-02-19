// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/ui/elements/homeitem.dart';

class ContentItem extends StatelessWidget {
  int listsize = 0;
  ContentItem({Key? key}) : super(key: key);

  get contentListSize => listsize;
  final Stream _docStream = FirebaseFirestore.instance
      .collection('todo')
      .doc(DatabaseContent.userID)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mp;
    return StreamBuilder(
      stream: _docStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          Object? snap = (snapshot.data);
          List contenT = (snap as dynamic)['names'];

          return (contenT.isNotEmpty)
              ? Column(
                  children: contenT.reversed
                      .map((mov) => Padding(
                            padding: const EdgeInsets.all(12),
                            child: Card(
                                child: (mov != null)
                                    ? ContentItemTile(mov)
                                    : Text("null")),
                          ))
                      .toList(),
                )
              : Center(child: Text("There is Nothing to Show"));
        }
      },
    );
  }
}
