// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/fire/error.dart';

Future<String?> signIn(String email, String pass) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      print('Uid not found');
      return null;
    }
  } catch (e) {
    if (e.hashCode == 185768934) {
      AuthError.logoutErrorMessage =
          "Invalid Password or User does not have a Password";
    }
    if (e.hashCode == 505284406) {
      AuthError.logoutErrorMessage = "User not found! Try creating new account";
    }
    if (e.hashCode == 140382746) {
      AuthError.logoutErrorMessage =
          "Account temporarily blocked due to too many bad requests";
    }
    print(e.hashCode);
    print(e);
    return null;
  }
}

Future<String?> register(String email, String pass, String userName) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.updateDisplayName(userName);
      return user.uid;
    } else {
      print('Uid not found');
      return null;
    }
  } catch (e) {
    // 34618382
    if (e.hashCode == 34618382) {
      AuthError.registerErrorMessage =
          "The email address is already in use by another account.";
    }
    print(e.hashCode);
    print(e);
    return null;
  }
}

Future signOut() async {
  try {
    return await FirebaseAuth.instance.signOut();
  } catch (e) {
    print(e.toString());
    return null;
  }
}
