import 'package:flutter/cupertino.dart';
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
                currentAccountPicture: const Icon(
                  CupertinoIcons.person_alt_circle,
                  size: 70,
                ),
              ),
            ),
            // ListTile(
            //   onTap: () async {
            //     if (DatabaseContent.usr != null &&
            //         !DatabaseContent.usr!.emailVerified) {
            //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //           content: Text('Check Your E-mail Account')));
            //       print("sending link");
            //       if (DatabaseContent.usr != null &&
            //           !DatabaseContent.usr!.emailVerified) {
            //         await DatabaseContent.usr!
            //             .sendEmailVerification()
            //             .then((value) {
            //           DatabaseContent.usr!.reload().then((value) =>
            //               {print(DatabaseContent.usr!.emailVerified)});
            //           print("going to verify");
            //           // DatabaseContent().isEmailVerified =
            //           //     DatabaseContent.usr!.emailVerified;
            //         });
            //       }
            //     }
            //   },
            //   leading: Icon(
            //     Icons.done_all,
            //   ),
            //   title: Text('Verify Email'),
            // ),
            ListTile(
              leading: const Icon(
                Icons.mail,
              ),
              title: const Text('Email'),
              subtitle: (mailId == null)
                  ? const Text("E mail not found")
                  : Text(mailId as String),
            ),
            ListTile(
              onTap: () async {
                print("logout presses");
                signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  // builder: (context) => Container(),
                  builder: (context) => const Authentication(),
                ));
              },
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
