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
  Future apiDataFun(String mname) async {
    Map<String, dynamic> apiData = await DatabaseContent().getRating(mname);
    return apiData;
  }

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
              // ? ListView.builder(
              //     reverse: true,
              //     itemCount: contenT.length,
              //     itemBuilder: (context, index) {
              //       // print(contenT[index]['mname']);
              //       return FutureBuilder(
              //           future: apiDataFun(contenT[index]['mname']),
              //           builder: (context, snapshot) {
              //             // print(snapshot);
              //             if (snapshot.connectionState ==
              //                 ConnectionState.done) {
              //               if (snapshot.hasData && !(snapshot.hasError)) {
              //                 print("connection done");
              //                 return Padding(
              //                   padding: const EdgeInsets.all(12.0),
              //                   child: Card(
              //                       borderOnForeground: false,
              //                       color: Colors.transparent,
              //                       elevation: 0,
              //                       child: ContentItemTile(snapshot.data)),
              //                 );
              //               } else {
              //                 print("has error");
              //                 return Center(child: CircularProgressIndicator());
              //               }
              //             } else {
              //               print("no conenction");
              //               return Center(child: CircularProgressIndicator());
              //             }
              //           });
              //       // return Text("Hello");
              //     })
              ? Column(
                  children: contenT.reversed
                      .map((mov) => Padding(
                            padding: const EdgeInsets.all(12),
                            child: Card(
                                elevation: 0,
                                color: Colors.transparent,
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
