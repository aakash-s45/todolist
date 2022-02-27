import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/ui/screens/detail.dart';

class ApiData extends StatelessWidget {
  final content;
  var obj = {
    "Title": "",
    "Year": "",
    "Released": "",
    "Runtime": "",
    "Genre": "",
    "Director": "",
    "Writer": "",
    "Actors": "",
    "Plot": "",
    "Language": "",
    "Country": "",
    "Awards": "",
    "Ratings": [
      {"Source": "", "Value": ""}
    ],
    "imdbRating": "",
    "imdbVotes": "",
    "imdbID": "",
    "BoxOffice": "",
    "Production": "",
    "Website": "",
    "Type": "",
    "totalSeasons": "",
    "Response": "True"
  };
  ApiData(this.content);

  Future apiDataFun(String mname) async {
    Map<String, dynamic> apiData = await DatabaseContent().getRating(mname);
    return apiData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiDataFun(content['mname']),
        builder: (context, snapshot) {
          // print(snapshot.toString());
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MovieDetail(obj, content);
            // return const Material(
            //     child: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && !(snapshot.hasError)) {
              // print(snapshot.data);
              return MovieDetail((snapshot.data), content);
            }
            return MovieDetail(obj, content);
            // return const Material(
            //     child: Center(child: CircularProgressIndicator()));
          }
          return MovieDetail(obj, content);
          // return const Material(
          //     child: Center(child: CircularProgressIndicator()));
        });
  }
}
