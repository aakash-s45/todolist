// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/fire/listcontent.dart';

class Home extends StatelessWidget {
  Home();
  void fun() {
    FirebaseFirestore.instance
        .collection('todo')
        .doc()
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
      }
    });
  }

  final TextEditingController _addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                  controller: _addController,
                  decoration: InputDecoration(
                    hintText: "Movie Name",
                    labelText: "New Entry",
                  )),
            ),
            ElevatedButton(
                onPressed: fun,
                child: Text("Add"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[700]))),
            Content(),
          ],
        ),
      ),
    );
  }
}
