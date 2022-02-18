// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/model/mytheme.dart';
import 'package:todolist/ui/screens/detail.dart';

class ContentItemTile extends StatefulWidget {
  final content;
  const ContentItemTile(this.content, {Key? key}) : super(key: key);

  @override
  State<ContentItemTile> createState() => _ContentItemTileState();
}

class _ContentItemTileState extends State<ContentItemTile> {
  Future openDeleteDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm to Delete"),
          content: Text(widget.content['mname']),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    DatabaseContent()
                        .removeContent(DatabaseContent.userID, widget.content);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${widget.content['mname']} deleted Successfully")));
                    Navigator.pop(context);
                  },
                  child: Text("Yes"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"),
                ),
              ],
            )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      // key: Key(widget.content['mname']),
      onDismissed: (direction) {
        openDeleteDialog();
        setState(() {});
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetail(widget.content)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: MyTheme.primaryColor,
            // color: Theme.of(context).canvasColor,
          ),
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Hero(
                tag: Key(widget.content['mname']),
                child: ContentImage(
                  image: widget.content['poster'],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: 50,
                          minWidth: 50,
                          maxHeight: 50,
                          maxWidth: 220),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.content['mname'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: MyTheme.secondaryColor),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 70.0,
                        child: Image.network(
                          'https://m.media-amazon.com/images/G/01/IMDb/BG_rectangle._CB1509060989_SY230_SX307_AL_.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.content['rating'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ContentImage extends StatelessWidget {
  final String image;
  const ContentImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          color: MyTheme.secondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(5),
        child: Image.network(
          image,
        ),
      ),
    );
  }
}
