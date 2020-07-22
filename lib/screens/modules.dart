import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Modules extends StatefulWidget {
    
  @override
  _ModulesState createState() => _ModulesState();
}

class _ModulesState extends State<Modules> {

  getModules() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    DocumentSnapshot doc = await Firestore.instance.collection('users').document(uid).collection('settings')
    .document('modules').get();
    return doc;
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

                      //Navigator.of(context).pop();

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