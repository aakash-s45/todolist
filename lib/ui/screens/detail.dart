// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todolist/model/mytheme.dart';

class MovieDetail extends StatelessWidget {
  final content;
  MovieDetail(this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: MyTheme.primaryColor,
        backgroundColor: MyTheme.secondaryColor,
        title: Text(""),
        centerTitle: true,
      ),
      body: Container(
        color: MyTheme.secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 184, 185, 185),
                          spreadRadius: 10,
                          blurRadius: 20,
                          offset: Offset(4, 8), // Shadow position
                        )
                      ]),
                  child: Hero(
                    tag: Key(content['Title']),
                    child: Image.network(
                      content['Poster'],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      content['Title'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(height: 5),
                    Text(content['Genre']),
                    SizedBox(height: 12),
                    Row(children: [
                      // breaking bad
                      SizedBox(
                        height: 25.0,
                        child: Image.network(
                          'https://m.media-amazon.com/images/G/01/IMDb/BG_rectangle._CB1509060989_SY230_SX307_AL_.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        content['imdbRating'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      Text(
                        "(${content['imdbVotes']})",
                        style: TextStyle(color: MyTheme.primaryColor),
                      ),
                    ]),
                    SizedBox(height: 10),
                    Text(
                      content["Released"],
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            //
            //
            //
            //
            //
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailTileBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTile(
                                    headingText: "Runtime",
                                    mainText: content['Runtime'],
                                  ),
                                  SizedBox(height: 10),
                                  (content['Type'] == "series")
                                      ? TextTile(
                                          headingText: "Season",
                                          mainText: content['totalSeasons'],
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 50,
                                    minWidth: 50,
                                    maxHeight: 50,
                                    maxWidth: 220),
                                child: SingleChildScrollView(
                                  child: TextTile(
                                      mainText: content['Language'],
                                      headingText: 'Language'),
                                  // child: Text(
                                  //   "${content['Language']}",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 15,
                                  //       color: MyTheme.secondaryColor),
                                  // ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    DetailTileBox(
                      child: TextTile(
                        headingText: "Plot",
                        mainText: content["Plot"],
                      ),
                    ),
                    DetailTileBox(
                      child: TextTile(
                        headingText: "Actors",
                        mainText: content["Actors"],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            //
            //
          ],
        ),
      ),
    );
  }
}

class DetailTileBox extends StatelessWidget {
  Widget child;
  DetailTileBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 184, 185, 185),
                spreadRadius: 10,
                blurRadius: 30,
                offset: Offset(4, 8), // Shadow position
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: MyTheme.primaryColor,
          ),
          child: child),
    );
  }
}

class TextTile extends StatelessWidget {
  final String headingText;
  final String mainText;
  TextStyle? mainStyle;
  TextStyle? headingStyle;

  TextTile({
    Key? key,
    required this.headingText,
    required this.mainText,
    this.mainStyle = MyTheme.mainTextTileStyle,
    this.headingStyle = MyTheme.headingTextTileStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headingText,
          style: headingStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          mainText,
          style: mainStyle,
        )
      ],
    );
  }
}
