// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class DatabaseContent {
  static bool isApiData = false;
  static bool apirun = false;
  static late String userID;
  static late User? usr;
  static late int contentListSize = 0;
  static late bool isVerified = false;

  set conListSize(int size) {
    contentListSize = size;
  }

  set setUserID(String uID) {
    userID = uID;
    // this is the userid
  }

  set setUser(user) {
    usr = user;
  }

  set isEmailVerified(bool val) {
    isVerified = val;
  }

  User? getUser() {
    final User? user = auth.currentUser;
    return user;
  }

  static List datalist = [];

  final CollectionReference todoRef =
      FirebaseFirestore.instance.collection('todo');
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUser(String userid) {
    return todoRef
        .doc(userid)
        .set({'id': userid, 'names': []})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future getRating(String mname) async {
    var url = 'http://www.omdbapi.com/?t=${mname}&apikey=5dc2abe2';
    http.Response response = await http.get(Uri.parse(url));
    Map data = json.decode(response.body);
    apirun = true;
    return data;
  }

  Future<void> addContent(String content, String userid) async {
    final docRef = todoRef.doc(userid);
    Map<String, dynamic> apiData = await getRating(content);
    print(apiData);
    if (apiData['Response'] == "True") {
      isApiData = true;

      Map<String, dynamic> contentObj = {
        'mname': apiData['Title'],
        'rating': apiData['imdbRating'],
        'poster': apiData['Poster'],
      };
      return todoRef.doc(userid).update({
        'names': FieldValue.arrayUnion([contentObj])
      });
    } else {
      isApiData = false;
    }
    // print(isApiData);
  }

  Future<String> getid() async {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }

  Future getContent(String userId) async {
    List contentList = [];
    try {
      await todoRef.doc(userId).get().then((document) {
        (document)['names'].forEach((names) {
          contentList.add(names);
        });
      });
      return contentList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future removeContent(String userId, dynamic content) {
    return todoRef.doc(userId).update({
      'names': FieldValue.arrayRemove([content])
    });
  }
}
