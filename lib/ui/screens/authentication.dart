// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/fire/error.dart';
import 'package:todolist/model/mytheme.dart';
import 'package:todolist/fire/fire.dart';
import 'package:todolist/ui/screens/home.dart';
import 'package:todolist/ui/screens/register.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailfeild = TextEditingController();
  TextEditingController _passfeild = TextEditingController();
  String getmailid() {
    return _emailfeild.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.secondaryColor,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: MyTheme.primaryColor,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: TextFormField(
                controller: _emailfeild,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'jhon@gmail.com',
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: TextFormField(
                enableSuggestions: false,
                obscureText: true,
                controller: _passfeild,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter the Password',
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: MyTheme.primaryColor,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    String? navi =
                        await signIn(_emailfeild.text, _passfeild.text);
                    _passfeild.clear();

                    if (navi != null) {
                      DatabaseContent dbcontent = DatabaseContent();
                      dbcontent.setUserID = navi;
                      DatabaseContent().setUser = DatabaseContent().getUser();
                      DatabaseContent().isEmailVerified =
                          DatabaseContent.usr!.emailVerified;
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AuthError.logoutErrorMessage)));
                    }
                  },
                  child: Text(
                    'login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyTheme.secondaryColor,
                    ),
                  ),
                )),
            SizedBox(height: 15),
            Container(
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                  child: Text(
                    'New user?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyTheme.primaryColor,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
