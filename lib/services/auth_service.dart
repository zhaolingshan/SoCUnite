import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
    (FirebaseUser user) => user?.uid,
  );

  //get UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  //email password sign up
  Future<String> createUserWithEmailAndPassword(String email, String password,
   String name) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email,
     password: password,);

    //Update username
    await updateUserName(name,authResult.user);
    return authResult.user.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  //email password login

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, 
    password: password)).user.uid;
  }

  //sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }




}

class EmailValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Email field cannot be empty";
    } else {
      return null;
    }
  }
}

class NameValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Username field cannot be empty";
    } 

    if(value.length < 2) {
      return "Username must be at least 2 characters long";
    }

    if(value.length > 50) {
      return "Username must be less than 50 characters";
    }
    else {
      return null;
    }
  }
}

class PasswordValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Password field cannot be empty";
    } 

    if(value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    
    else {
      return null;
    }
  }
}