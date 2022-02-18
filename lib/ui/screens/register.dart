import 'package:flutter/material.dart';
import 'package:todolist/fire/dbContent.dart';
import 'package:todolist/fire/error.dart';
import 'package:todolist/model/mytheme.dart';
import 'home.dart';
import '../../fire/fire.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String userID;
  final TextEditingController _usernamefeild = TextEditingController();
  final TextEditingController _emailfeild = TextEditingController();
  final TextEditingController _passfeild = TextEditingController();
  final TextEditingController _confpassfeild = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
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
                  controller: _usernamefeild,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Jhon The Don',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  controller: _emailfeild,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'jhon@gmail.com',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  obscureText: true,
                  controller: _passfeild,
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  obscureText: true,
                  controller: _confpassfeild,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm password',
                    hintText: 'Confirm Password',
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: MyTheme.primaryColor,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      // this navi is user id
                      String? navi;
                      if (_passfeild.text != _confpassfeild.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Password not matching")));
                      } else if (_passfeild.text.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Password should be at least 6 characters")));
                      } else {
                        navi = await register(_emailfeild.text, _passfeild.text,
                            _usernamefeild.text);
                        _emailfeild.clear();
                        if (navi != null) {
                          userID = navi;
                          DatabaseContent dbcontent = DatabaseContent();
                          dbcontent.setUserID = navi;
                          DatabaseContent().addUser(navi);
                          DatabaseContent().setUser =
                              DatabaseContent().getUser();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AuthError.registerErrorMessage)));
                        }
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
