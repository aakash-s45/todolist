import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:todolist/model/mytheme.dart';

class MovieDetail extends StatelessWidget {
  final content;
  const MovieDetail(this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: MyTheme.primaryColor,
        backgroundColor: MyTheme.secondaryColor,
        title: Text(content['mname']),
        centerTitle: true,
      ),
      body: Container(
        color: MyTheme.secondaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.network(content['poster']),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
                  opacity: .6,
                  image: NetworkImage(content['poster']),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
