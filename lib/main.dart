// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/ui/screens/authentication.dart';
import 'package:todolist/ui/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'App',
    home: await getLandingPage(),
  ));
}

Future<Widget> getLandingPage() async {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData && (!snapshot.data!.isAnonymous)) {
        DatabaseContent().setUser = snapshot.data;
        DatabaseContent().setUserID = snapshot.data!.uid;
        print("Logged in:- main");
        return Home();
      }
      print("Logged out:- main");
      return Authentication();
    },
  );
}
