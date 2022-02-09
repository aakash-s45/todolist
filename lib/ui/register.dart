import 'package:flutter/material.dart';
import 'home.dart';
import 'fire.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailfeild = TextEditingController();
  TextEditingController _passfeild = TextEditingController();
  TextEditingController _confpassfeild = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
          backgroundColor: Colors.grey[700],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  controller: _emailfeild,
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'jhon@gmail.com',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  controller: _passfeild,
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'password',
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: TextFormField(
                  controller: _confpassfeild,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'confirm password',
                    hintText: 'confirm Password',
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      bool navi =
                          await register(_emailfeild.text, _passfeild.text);
                      // print(navi);
                      if (navi && _passfeild.text == _confpassfeild.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Confirm your Password")));
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
