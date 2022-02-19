import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/ui/screens/detail.dart';

class ApiData extends StatelessWidget {
  final content;
  const ApiData(this.content);
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
            return const Material(
                child: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && !(snapshot.hasError)) {
              // print(snapshot.data);
              return MovieDetail(snapshot.data);
              // return Text(snapshot.data.toString());
            }
            return const Material(
                child: Center(child: CircularProgressIndicator()));
            // return Text("has error or dont have dat");
          }
          // return Text("connection error");
          return const Material(
              child: Center(child: CircularProgressIndicator()));
        });
    // return Text("he");
  }
}
