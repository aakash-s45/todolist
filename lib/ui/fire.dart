// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String pass) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String pass) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
