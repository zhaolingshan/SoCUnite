import 'package:SoCUniteTwo/forums_data/module_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forum_screens/CS2030.dart';
import 'package:SoCUniteTwo/screens/forum_screens/CS2040S.dart';
//import 'package:SoCUniteTwo/screens/forum_screens/CS2030_forum.dart';

class ModuleScreen extends StatefulWidget { //list of modules


  @override
  _ModuleScreenState createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  
//List<String> modules = ['test', 'test', 'test', 'test', 'test']; //need to extract fields from document

  getModules() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    DocumentSnapshot doc = await Firestore.instance.collection('users').document(uid).collection('settings')
    .document('modules').get();
    return doc;
  }

  Widget getmodule1(context, snapshot) {
  return Text(snapshot.data['module1'], style: TextStyle(fontSize: 20, color: Colors.grey[100]));  
  }

  Widget getmodule2(context, snapshot) {
  return Text(snapshot.data['module2'], style: TextStyle(fontSize: 20, color: Colors.grey[100]));      
  }

  Widget getmodule3(context, snapshot) {
  return Text(snapshot.data['module3'], style: TextStyle(fontSize: 20, color: Colors.grey[100]));      
  }

  Widget getmodule4(context, snapshot) {
  return Text(snapshot.data['module4'], style: TextStyle(fontSize: 20, color: Colors.grey[100]));      
  }

  Widget getmodule5(context, snapshot) {
  return Text(snapshot.data['module5'], style: TextStyle(fontSize: 20, color: Colors.grey[100]));      
  }

  


  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _loadData();
    // });
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
        title: Text("My Modules"),
        actions: <Widget>[
          IconButton(onPressed: (){
            showSearch(context: context, delegate: ModuleCodeSearch());
          },
            icon: Icon(Icons.search),

            
          )
        ],
      ),
      body: ListView( 
        children: <Widget>[
          Card(
            color: Colors.grey[850],
            child: ListTile( //must always display CS2030
              onTap: () {
                Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CS2030()));
              },
              title: //Text(modules[0], style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              FutureBuilder(
              future: getModules(),
             builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return getmodule1(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CS2040S()));
              },
              title: FutureBuilder(
              future: getModules(),
             builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return getmodule2(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: () {},
              title:  FutureBuilder(
              future: getModules(),
             builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return getmodule3(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: () {},
              title:  FutureBuilder(
              future: getModules(),
             builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return getmodule4(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: (){},
              title:  FutureBuilder(
              future: getModules(),
             builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return getmodule5(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
        ],
      ),
    );
  }
}

class ModuleCodeSearch extends SearchDelegate<ModuleCodes> {
  @override 
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back),);
  }

  Widget buildResults(BuildContext context) { //edit
    return Center(child: Text(query, style: TextStyle(fontSize: 20)));
  }

  Widget buildSuggestions(BuildContext context) {

    final myList = query.isEmpty ? loadModuleCodes() : loadModuleCodes().where((p) => 
    p.moduleCode.startsWith(query)).toList();

    return myList.isEmpty ? Text('No results found',
    style: TextStyle(fontSize: 20),) :
    ListView.builder(
      itemCount: myList.length,
      itemBuilder: (context, index) {
        final ModuleCodes listitem = myList[index];
        return ListTile(
        onTap: () {
          //showResults(context);
          if(listitem.moduleCode == 'CS2030') {
            Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => CS2030()));
          } else if (listitem.moduleCode == 'CS2040S') {
            Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => CS2040S()));
          }
        },
        title: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(listitem.moduleCode, style: TextStyle(fontSize: 20
            ),
          ),
            Divider()
          ],
        ),
        
        );
      });
  }
}