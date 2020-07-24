import 'package:cloud_firestore/cloud_firestore.dart';

class Module {
  String code;

  Module(
    this.code,
  );

  Module.fromSnapshot(DocumentSnapshot snapshot) : 
  code = snapshot['code'];
}