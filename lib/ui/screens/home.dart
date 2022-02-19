// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/fire/error.dart';
import 'package:todolist/ui/contentreal.dart';
import 'package:todolist/model/mytheme.dart';
import 'package:todolist/ui/elements/drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _addController = TextEditingController();

  List userContentList = [];

  @override
  void initState() {
    super.initState();
    fetchContentList();
  }

  fetchContentList() async {
    dynamic result = await DatabaseContent().getContent(DatabaseContent.userID);
    if (result == null) {
      print("Unable to fetch");
    } else {
      setState(() {
        userContentList = result;
      });
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
                // print("poped alert box");
                // print('home is apidata ${DatabaseContent.isApiData}');
                // print('home api run ${DatabaseContent.apirun}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.secondaryColor,
        onPressed: () {
          openDiaglog();
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
              child: Text(
                "Shows List",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800),
              ),
            ),
            // MovieAddBar(addController: _addController),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: MyTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    child: ContentItem(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
