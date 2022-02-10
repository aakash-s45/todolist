// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:todolist/model/content.dart';
import 'package:todolist/ui/listtile.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

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
    dynamic result = await DatabaseContent().getContent();
    if (result == null) {
      print("Unable to fetch");
    } else {
      setState(() {
        userContentList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: _addController,
                        decoration: InputDecoration(
                          hintText: "Movie Name",
                          labelText: "New Entry",
                        )),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Add"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[700]))),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: userContentList
                        // .map((docData) => Text('hello'))
                        .map((docData) => Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              child: ContentTile(docData['name']),
                            ))
                        .toList(),
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
