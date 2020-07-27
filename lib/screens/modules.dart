//import 'package:SoCUniteTwo/providers/module.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Modules extends StatefulWidget {
    
  @override
  _ModulesState createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {
  // String mod1 = '';
  // String mod2 = '';
  // String mod3 = '';
  // String mod4 = '';
  // String mod5 = '';
  
  // getModules() async {
  //   final uid = await Provider.of(context).auth.getCurrentUID();
  //   DocumentSnapshot doc = await Firestore.instance.collection('users').document(uid).collection('settings')
  //   .document('modules').get();
  //   return doc;
  // } //ORIGINAL

  getModules() async {
      final uid = await Provider.of(context).auth.getCurrentUID();
      Firestore.instance.collection('users').document(uid).collection('settings')
          .document('modules').get().then((ds) {
        _module1Controller.text = ds.data['module1'];
         _module2Controller.text = ds.data['module2'];
          _module3Controller.text = ds.data['module3'];
           _module4Controller.text = ds.data['module4'];
            _module5Controller.text = ds.data['module5'];
        /// now _module1Controller.text contains the text from database....
      });

      // setState(() {
      //   mod1 = _module1Controller.text;
      //   mod2 = _module2Controller.text;
      //   mod3 = _module3Controller.text;
      //   mod4 = _module4Controller.text;
      //   mod5 = _module5Controller.text;
      // });
      
    }

  TextEditingController _module1Controller = new TextEditingController();
    TextEditingController _module2Controller = new TextEditingController();
    TextEditingController _module3Controller = new TextEditingController();
    TextEditingController _module4Controller = new TextEditingController();
    TextEditingController _module5Controller = new TextEditingController();
    //TextEditingController _module6Controller = new TextEditingController();
    //TextEditingController _module7Controller = new TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    getModules();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ) ,
      title: Text("Your Modules",) 
    ),
    body: Builder(builder: (context) {
      return SingleChildScrollView(child:Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Row(children: <Widget>[
            SizedBox(width: 15,),
            Text("Module 1", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
            SizedBox(width: 30,),
            Expanded(child: 
             TextFormField(
               style: TextStyle(color: Colors.grey[100]),
               cursorColor: Colors.tealAccent,
               controller: _module1Controller, 
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[100], fontSize: 15),
                hintText: "Eg. CS2030, IS1103, MA1101R",
               focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
             ),
             ),)
          ],),
          SizedBox(height: 10,),
          Row(children: <Widget>[
            SizedBox(width: 15,),
            Text("Module 2", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
            SizedBox(width: 30,),
            Expanded(child: 
             TextFormField(
               style: TextStyle(color: Colors.grey[100]),
               cursorColor: Colors.tealAccent,
               controller: _module2Controller,
               decoration: InputDecoration(
                 hintStyle: TextStyle(color: Colors.grey[100],fontSize: 15),
                 hintText: "Eg. CS2030, IS1103, MA1101R",
               focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
             ),
             ),)
          ],),
          SizedBox(height: 10,),
          Row(children: <Widget>[
            SizedBox(width: 15,),
            Text("Module 3", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
            SizedBox(width: 30,),
            Expanded(child: 
             TextFormField(
               style: TextStyle(color: Colors.grey[100]),
               cursorColor: Colors.tealAccent,
               controller: _module3Controller,
               decoration: InputDecoration(
                 hintStyle: TextStyle(color: Colors.grey[100], fontSize: 15),
                 hintText: "Eg. CS2030, IS1103, MA1101R",
               focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
             ),
             ),)
          ],),
          SizedBox(height: 10,),
          Row(children: <Widget>[
            SizedBox(width: 15,),
            Text("Module 4", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
            SizedBox(width: 30,),
            Expanded(child: 
             TextFormField(
               style: TextStyle(color: Colors.grey[100]),
               cursorColor: Colors.tealAccent,
               controller: _module4Controller,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey[100], fontSize: 15),
                hintText: "Eg. CS2030, IS1103, MA1101R",
               focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
             ),))
          ],),
          SizedBox(height: 10,),
          Row(children: <Widget>[
            SizedBox(width: 15,),
            Text("Module 5", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
            SizedBox(width: 30,),
            Expanded(child: 
             TextFormField(
               style: TextStyle(color: Colors.grey[100]),
               cursorColor: Colors.tealAccent,
               controller: _module5Controller,
               decoration: InputDecoration(
                 hintStyle: TextStyle(color: Colors.grey[100], fontSize: 15),
                 hintText: "Eg. CS2030, IS1103, MA1101R",
               focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
               ),
             ),)
          ],),
          SizedBox(height: 10,),
          // Row(children: <Widget>[
          //   SizedBox(width: 15,),
          //   Text("Module 6", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
          //   SizedBox(width: 30,),
          //   Expanded(child: 
          //    TextFormField(
          //      style: TextStyle(color: Colors.grey[100]),
          //      cursorColor: Colors.tealAccent,
          //      controller: _module6Controller,
          //      decoration: InputDecoration(
          //        hintStyle: TextStyle(color: Colors.grey[100], fontSize: 15),
          //        hintText: "Eg. CS2030, IS1103, MA1101R",
          //      focusedBorder: UnderlineInputBorder(
          //                     borderSide: BorderSide(color: Colors.tealAccent,
          //                     ),),
          //                   enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
          //    ),
          //    ),)
          // ],),
          // SizedBox(height: 10,),
          // Row(children: <Widget>[
          //   SizedBox(width: 15,),
          //   Text("Module 7", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
          //   SizedBox(width: 30,),
          //   Expanded(child: 
          //    TextFormField(
          //      style: TextStyle(color: Colors.grey[100]),
          //      cursorColor: Colors.tealAccent,
          //      controller: _module7Controller,
          //      decoration: InputDecoration(
          //        hintStyle: TextStyle(color: Colors.grey[100], fontSize: 15),
          //        hintText: "Eg. CS2030, IS1103, MA1101R",
          //      focusedBorder: UnderlineInputBorder(
          //                     borderSide: BorderSide(color: Colors.tealAccent,
          //                     ),),
          //                   enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
          //    ),
          //    ),)
          // ],),  
          SizedBox(height: 100,),
          //displayUserModules(context, snapshot),
          RaisedButton(
            onPressed: () async {        
             final uid = await Provider.of(context).auth.getCurrentUID();
             final user = await FirebaseAuth.instance.currentUser();

              await Firestore.instance.collection("users").document(uid)
              .collection('settings').document('modules').setData({
                        "module1" : _module1Controller.text,
                        "module2" : _module2Controller.text,
                        "module3" : _module3Controller.text,
                        "module4" : _module4Controller.text,
                        "module5" : _module5Controller.text,
                        // "module6" : _module6Controller.text,
                        // "module7" : _module7Controller.text,
                      }, merge : true).then((_){
                        print("modules upload success!");
                      });

              await Firestore.instance.collection('users').document(uid)
              .collection('my_modules_chats').document(_module1Controller.text)
              .setData({
                'code': _module1Controller.text,
              }); // create private collection for module1

              await Firestore.instance.collection('users').document(uid)
              .collection('my_modules_chats').document(_module2Controller.text)
              .setData({
                'code': _module2Controller.text,
              }); // create private collection for module2

              await Firestore.instance.collection('users').document(uid)
              .collection('my_modules_chats').document(_module3Controller.text)
              .setData({
                'code': _module3Controller.text,
              }); // create private collection for module3

              await Firestore.instance.collection('users').document(uid)
              .collection('my_modules_chats').document(_module4Controller.text)
              .setData({
                'code': _module4Controller.text,
              }); // create private collection for module4

              await Firestore.instance.collection('users').document(uid)
              .collection('my_modules_chats').document(_module5Controller.text)
              .setData({
                'code': _module5Controller.text,
              }); // create private collection for module5

              await Firestore.instance.collection(_module1Controller.text)
              .add({
                'text': 'Welcome to the ' + _module1Controller.text + ' Chatroom, ' + user.displayName + '!',
                'createdAt': Timestamp.now(),
                'userId': '',
                'username': 'Admin',
              }); // create public collection for module1

              await Firestore.instance.collection(_module2Controller.text)
              .add({
                'text': 'Welcome to the ' + _module2Controller.text + ' Chatroom, ' + user.displayName + '!',
                'createdAt': Timestamp.now(),
                'userId': '',
                'username': 'Admin',
              }); // create public collection for module2

              await Firestore.instance.collection(_module3Controller.text)
              .add({
                'text': 'Welcome to the ' + _module3Controller.text + ' Chatroom, ' + user.displayName + '!',
                'createdAt': Timestamp.now(),
                'userId': '',
                'username': 'Admin',
              }); // create public collection for module3

              await Firestore.instance.collection(_module4Controller.text)
              .add({
                'text': 'Welcome to the ' + _module4Controller.text + ' Chatroom, ' + user.displayName + '!',
                'createdAt': Timestamp.now(),
                'userId': '',
                'username': 'Admin',
              }); // create public collection for module4

              await Firestore.instance.collection(_module5Controller.text)
              .add({
                'text': 'Welcome to the ' + _module5Controller.text + ' Chatroom, ' + user.displayName + '!',
                'createdAt': Timestamp.now(),
                'userId': '',
                'username': 'Admin',
              }); // create public collection for module5

               await Firestore.instance.collection(_module1Controller.text)
               .getDocuments().then((querySnapshot) {
                querySnapshot.documents.forEach((element) async { // element refers to each text
                  await Firestore.instance.collection('users').document(uid)
                  .collection('my_modules_chats').document(_module1Controller.text)
                  .collection(_module1Controller.text).add({
                    'text': element.data['text'],
                    'createdAt': element.data['createdAt'],
                    'userId': element.data['userId'],
                    'username': element.data['username'],
                  });
                });
              }); // update texts from public into private for module1

               await Firestore.instance.collection(_module2Controller.text)
               .getDocuments().then((querySnapshot) {
                querySnapshot.documents.forEach((element) async { // element refers to each text
                  await Firestore.instance.collection('users').document(uid)
                  .collection('my_modules_chats').document(_module2Controller.text)
                  .collection(_module2Controller.text).add({
                    'text': element.data['text'],
                    'createdAt': element.data['createdAt'],
                    'userId': element.data['userId'],
                    'username': element.data['username'],
                  });
                });
              }); // update texts from public into private for module2

               await Firestore.instance.collection(_module3Controller.text)
               .getDocuments().then((querySnapshot) {
                querySnapshot.documents.forEach((element) async { // element refers to each text
                  await Firestore.instance.collection('users').document(uid)
                  .collection('my_modules_chats').document(_module3Controller.text)
                  .collection(_module3Controller.text).add({
                    'text': element.data['text'],
                    'createdAt': element.data['createdAt'],
                    'userId': element.data['userId'],
                    'username': element.data['username'],
                  });
                });
              }); // update texts from public into private for module3

               await Firestore.instance.collection(_module4Controller.text)
               .getDocuments().then((querySnapshot) {
                querySnapshot.documents.forEach((element) async { // element refers to each text
                  await Firestore.instance.collection('users').document(uid)
                  .collection('my_modules_chats').document(_module4Controller.text)
                  .collection(_module4Controller.text).add({
                    'text': element.data['text'],
                    'createdAt': element.data['createdAt'],
                    'userId': element.data['userId'],
                    'username': element.data['username'],
                  });
                });
              }); // update texts from public into private for module4

               await Firestore.instance.collection(_module5Controller.text)
               .getDocuments().then((querySnapshot) {
                querySnapshot.documents.forEach((element) async { // element refers to each text
                  await Firestore.instance.collection('users').document(uid)
                  .collection('my_modules_chats').document(_module5Controller.text)
                  .collection(_module5Controller.text).add({
                    'text': element.data['text'],
                    'createdAt': element.data['createdAt'],
                    'userId': element.data['userId'],
                    'username': element.data['username'],
                  });
                });
              }); // update texts from public into private for module5

              //updating modules for chats

              // await Firestore.instance.collection('users').document(uid)
              // .collection('my_modules_chats').document(mod1).delete();

              // await Firestore.instance.collection('users').document(uid)
              // .collection('my_modules_chats').document(mod2).delete();

              // await Firestore.instance.collection('users').document(uid)
              // .collection('my_modules_chats').document(mod3).delete();

              //  await Firestore.instance.collection('users').document(uid)
              // .collection('my_modules_chats').document(mod4).delete();

              // await Firestore.instance.collection('users').document(uid)
              // .collection('my_modules_chats').document(mod5).delete();
              



              final snackBar = SnackBar(
              content: Text('Uploading of modules is successful!'),
              duration: Duration(seconds: 3),
              );

              Scaffold.of(context).showSnackBar(snackBar);

            },
            
            color: Colors.blue[300],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Text("Update modules", style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
      ],));
      }));
  }



}