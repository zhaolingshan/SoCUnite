import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/providers/module.dart';
import 'package:SoCUniteTwo/screens/chat_screens/module_chat_screen.dart';

class ModulesChatsListviewScreen extends StatefulWidget {
  @override
  _ModulesChatsListviewScreenState createState() => _ModulesChatsListviewScreenState();
}

class _ModulesChatsListviewScreenState extends State<ModulesChatsListviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getModulesChatsSnapshot(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return 
            Center(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              CircularProgressIndicator()
            ],)); 
            return new ListView.builder(
          itemBuilder: (BuildContext context, int index) 
          => buildModulesChats(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getModulesChatsSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid)
    .collection('my_modules_chats')
    .snapshots();
  }

  Widget buildModulesChats(BuildContext context, DocumentSnapshot module) {
    final moduleforEachChat = Module.fromSnapshot(module);
    String description = 'A chat dedicated for ' +  module['code'];
    return Container(
      child: Builder(
        builder: (context) {
          return Card(
            color: Colors.grey[850],
            child: InkWell(
              onTap: () async { 
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ModuleChatScreen(module: moduleforEachChat,),
                  )
                );
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20,),
                              Text(
                                module['code'], 
                                style: TextStyle(
                                  fontSize: 17, 
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue[300]
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20,),
                              Text(
                                description, 
                                style: TextStyle(
                                  fontSize: 15, 
                                  color: Colors.grey[100],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      )
    );         
  }
}