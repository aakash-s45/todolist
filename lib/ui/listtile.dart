import 'package:flutter/material.dart';

class ContentTile extends StatelessWidget {
  String content;
  ContentTile(this.content);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
            constraints: BoxConstraints(minHeight: 60),
            // width: MediaQuery.of(context).size.width * 4 / 5,
            child: Center(
              child: Text(
                content,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Icon(
          Icons.delete,
          color: Colors.white,
          size: 34,
        ),
        // Expanded(
        //   child: Container(
        //     constraints: BoxConstraints(minHeight: 60),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(7),
        //       color: Colors.white,
        //     ),
        //     // width: MediaQuery.of(context).size.width / 5,
        //     child: Center(
        //         child: Text(
        //       'x',
        //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25.0),
        //     )),
        //   ),
        // )
      ],
    );
  }
}
