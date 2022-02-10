import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseContent {
  static List datalist = [];
  final CollectionReference todoRef =
      FirebaseFirestore.instance.collection('todo');

  Future getContent() async {
    List contentList = [];
    try {
      await todoRef.get().then((querySnapshot) {
        querySnapshot.docs.forEach((document) {
          contentList.add(document.data());
        });
      });
      return contentList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
