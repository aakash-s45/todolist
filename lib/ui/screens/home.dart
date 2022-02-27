// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/ui/contentreal.dart';
import 'package:todolist/model/mytheme.dart';
import 'package:todolist/ui/elements/drawer.dart';
import 'package:todolist/ui/screens/detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _addController = TextEditingController();

  Timer? timer;

  @override
  void initState() {
    super.initState();
    DatabaseContent().isEmailVerified =
        FirebaseAuth.instance.currentUser!.emailVerified;
    if (!(FirebaseAuth.instance.currentUser!.emailVerified)) {
      sendVerificationEmail();
      print("email verification sent");
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerifeid());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something Get Wrong')));
      e.toString();
    }
  }

  Future checkEmailVerifeid() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      DatabaseContent().isEmailVerified =
          FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (DatabaseContent.isVerified) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email verified 🔥')));
      timer?.cancel();
    }
  }

  Future openDiaglog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add Show"),
          content: TextField(
            enableSuggestions: false,
            controller: _addController,
            decoration: InputDecoration(hintText: "Enter movie name"),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(MyTheme.primaryColor),
              ),
              onPressed: () async {
                await DatabaseContent()
                    .addContent(_addController.text, DatabaseContent.userID);
                _addController.clear();
                Navigator.pop(context);
                if (DatabaseContent.isApiData == false &&
                    DatabaseContent.apirun == true) {
                  print("api data is not present on pressed");
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("No Mactching Movie/TV Show")));
                }
                DatabaseContent.apirun = false;
                DatabaseContent.isApiData = false;
              },
              child: Text("Add"),
            )
          ],
        ),
      );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.secondaryColor,
        onPressed: () {
          if (DatabaseContent.isVerified) {
            openDiaglog();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('First verify your email!')));
          }
        },
        child: Icon(
          CupertinoIcons.add_circled,
          color: MyTheme.primaryColor,
        ),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        size: 40,
                      ),
                    ),
                  ),
                  Text(
                    "Shows List",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: MyTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  // child: ContentItem(),
                  child: SingleChildScrollView(
                    child: ContentItem(),
                  ),
                ),
              ),
            ),
            if (!DatabaseContent.isVerified)
              DetailTileBox(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Wrap(
                      children: [
                        Text(
                          "Email Verification link Sent! Click on the link to get verified",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
