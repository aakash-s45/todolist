import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/model/mytheme.dart';
import 'package:todolist/ui/screens/authentication.dart';
import 'package:todolist/fire/fire.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? mailId = DatabaseContent().getUser()?.email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: MyTheme.secondaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                margin: EdgeInsets.zero,
                accountName: (DatabaseContent.usr!.displayName == null)
                    ? const Text("Name not found")
                    : Text(DatabaseContent.usr!.displayName as String),
                accountEmail: (mailId == null)
                    ? const Text("E mail not found")
                    : Text(mailId as String),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.images.express.co.uk/img/dynamic/39/590x/Game-of-Thrones-White-Walker-theory-1233486.webp?r=1579995873278"),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            ListTile(
              leading: const Icon(
                Icons.mail,
              ),
              title: Text('Email'),
              subtitle: (mailId == null)
                  ? Text("E mail not found")
                  : Text(mailId as String),
            ),
            ListTile(
              onTap: () async {
                print("logout presses");
                signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  // builder: (context) => Container(),
                  builder: (context) => Authentication(),
                ));
              },
              leading: Icon(
                Icons.add_business,
              ),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
