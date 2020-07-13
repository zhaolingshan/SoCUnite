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
List<String> modules = ['CS2030', 'CS2040S', 'IS1103', 'MA1101R', 'GER1000']; //need to extract fields from document

  List<String> mods = [];

  

  void _loadData() async{
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Firestore.instance.collection("users").document(uid).collection('settings')
    .document('modules').get().then((value) async {
      //for(int i = 0; i < value.data.length; i++) {
        mods.add(value.data['module1']);
        mods.add(value.data['module2']);
        mods.add(value.data['module3']);
        mods.add(value.data['module4']);
        mods.add(value.data['module5']);
        //print(value.data);
        //make it such that CS2030 is always the first module 
    //}
      print(mods);
      
    });
  }

  // void initState() {
  //   super.initState();
  //  WidgetsBinding.instance.addPostFrameCallback((_){
  //   _loadData();
  // });

  

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
      body: ListView( //for loop the list???
        children: <Widget>[
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CS2030()));
              },
              title: Text(modules[0], style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                Navigator.push(context, 
              MaterialPageRoute(builder: (context) => CS2040S()));
              },
              title: Text(modules[1], style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: () {},
              title: Text(modules[2], style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: () {},
              title: Text(modules[3], style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[100]),
            ),),
            Card(
              color: Colors.grey[850],
            child: ListTile(
              onTap: (){},
              title: Text(modules[4], style: TextStyle(fontSize: 20, color: Colors.grey[100])),
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