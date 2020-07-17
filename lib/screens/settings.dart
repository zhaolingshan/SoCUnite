import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:SoCUniteTwo/services/auth_service.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Settings extends StatefulWidget {
  
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int karmaPts = 0;


  Future<int> getKarmaPointsfromPosts() async {
    //int karmaPts = 0;
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Firestore.instance.collection('users').document(uid).collection('private_forums')
    .getDocuments().then((querySnapshot) { //list of documents 
       querySnapshot.documents.forEach((result) async { //each documentid is result 
       int i = result.data['upvotes'].values.where((e)=> e as bool).length;     
       print('i:'+i.toString());
         karmaPts = karmaPts + i;    

    });
    });
    await Firestore.instance.collection('users').document(uid).collection('private_feedbacks')
    .getDocuments().then((querySnapshot) { //list of documents 
       querySnapshot.documents.forEach((result) async { //each documentid is result 
       int j = result.data['upvotes'].values.where((e)=> e as bool).length;
       karmaPts = karmaPts + j;
       print('j:'+j.toString());
      
    });
    });

    await Firestore.instance.collection('users').document(uid).collection('private_notes')
    .getDocuments().then((querySnapshot) { //list of documents 
       querySnapshot.documents.forEach((result) async { //each documentid is result 
       int k = result.data['upvotes'].values.where((e)=> e as bool).length;
       karmaPts = karmaPts + k;
       print('k:'+k.toString());
       
    });
    });

    await Firestore.instance.collection('users').document(uid).collection('private_experiences')
    .getDocuments().then((querySnapshot) { //list of documents 
       querySnapshot.documents.forEach((result) async { //each documentid is result 
       int l = result.data['upvotes'].values.where((e)=> e as bool).length;
       karmaPts = karmaPts + l;
       print('l:'+l.toString());
       
    });
    });

    await Firestore.instance.collection('users').document(uid).collection('private_offers')
    .getDocuments().then((querySnapshot) { //list of documents 
       querySnapshot.documents.forEach((result) async { //each documentid is result 
       int m = result.data['upvotes'].values.where((e)=> e as bool).length;
       karmaPts = karmaPts + m;
       print('m:'+m.toString());
    });
    });

    await Firestore.instance.collection('users').document(uid).collection('private_collaborations')
    .getDocuments().then((querySnapshot) { //list of documents 
       querySnapshot.documents.forEach((result) async { //each documentid is result 
       int n = result.data['upvotes'].values.where((e)=> e as bool).length;
       karmaPts = karmaPts + n;
       print('n:'+n.toString());
    });
    });


    // await Firestore.instance.collection('public').document('CS2030').collection('Forums')
    // .getDocuments().then((querySnapshot) { //list of documents 
    //    querySnapshot.documents.forEach((result) async { //each post is result 
    //    Firestore.instance.collection('public').document('CS2030').collection('Forums')
    //    .document(result.documentID).collection('comments').where('ownerid', isEqualTo: uid).getDocuments()
    //    .then((value) async {
    //      value.documents.forEach((result) async { 
    //      int a = result.data['upvotes'].values.where((e)=> e as bool).length;
    //      print('a: ' + a.toString());
    //      karmaPts = karmaPts + a;
    //    }); 
    // });
    // });
    // });

   print('karmaPts:' + karmaPts.toString());
    return karmaPts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[900],
      appBar: 
    AppBar(title: Text("Settings"),
     backgroundColor: Colors.grey[850]),
    body: Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(8),
            color: Colors.tealAccent,
            child: ListTile(
              onTap: () { //open to edit profile
                Navigator.of(context).pushNamed('/profile');
              },
              title: Text("Profile", style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              // leading: CircleAvatar( //profile picture
              //   backgroundColor: Colors.grey,
              //   backgroundImage: _pickedImage != null ? FileImage(_pickedImage) :
              //   null,
              // ),
              trailing: Icon(Icons.edit, color: Colors.grey[900],),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(32),
            color: Colors.grey[850],
            child:        
            FutureBuilder<int>(
              future: getKarmaPointsfromPosts(),
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if(snapshot.hasData){
                return Text('Your karma points : ${snapshot.data}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100], 
              fontSize: 18),
              textAlign: TextAlign.center);
              }
              return Text('Your karma points : calculating...', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100], 
              fontSize: 18),
              textAlign: TextAlign.center);
            },
              )
          ),
          Card(
            color: Colors.grey[850],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                ListTile(
              onTap: () { //open to change password
                Navigator.of(context).pushNamed('/passwordchange');
              },
              leading: Icon(Icons.lock, color: Colors.lightBlueAccent[100],),
              title: Text("Change password", style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 17),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.lightBlueAccent[100],),
            ),
            Divider(
              color: Colors.grey[700],
              thickness: 1,),
            ListTile(
              onTap: () { //open to update timetable
                Navigator.of(context).pushNamed('/timetable');
              },
              leading: Icon(Icons.event_available, color: Colors.lightBlueAccent[100],),
              title: Text("Update your timetable", style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 17),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.lightBlueAccent[100],),
            ),
            Divider(
              color: Colors.grey[700],
              thickness: 1,),
            ListTile(
              onTap: () { //open to update modules
                Navigator.of(context).pushNamed('/modules');
              },
              leading: Icon(Icons.subject, color: Colors.lightBlueAccent[100],),
              title: Text("Update your modules", style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold, fontSize: 17),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.lightBlueAccent[100],),
            ),
              ],),
          ),
          SizedBox(height: 20),
          SwitchListTile(
            activeColor: Colors.tealAccent,
            title: Text("   Receive notifications",
            style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
            ),
            value: true,
            onChanged: (value) {}, //receive notifications
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                // Navigator.of(context).pushNamedAndRemoveUntil('/begin',
                //  (Route<dynamic> route) => false);
              },
              color: Colors.blue[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text("Logout", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  ),
                  ),
        ],
      )
    );}),
    );
  }
}