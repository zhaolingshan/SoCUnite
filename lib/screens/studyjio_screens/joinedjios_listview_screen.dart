import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/studyjios/joinstudyjio.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/studyjio_detail_screen.dart';

class JoinedjiosListviewScreen extends StatefulWidget {

  @override
  _JoinedjiosListviewScreenState createState() => _JoinedjiosListviewScreenState();
}

class _JoinedjiosListviewScreenState extends State<JoinedjiosListviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersJoinedStudyjiosSnapshot(context),
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
          => buildJoinedJios(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
        }
        ),
      ),
    );
  }

    Stream<QuerySnapshot> getUsersJoinedStudyjiosSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid)
    .collection('joined_studyjios').snapshots();
  }

  Widget buildJoinedJios(BuildContext context, DocumentSnapshot studyjio) {
    final joinedJio = Studyjio.fromSnapshot(studyjio);
    return Container(
      child: Builder(
        builder: (context) {
          return Card(
            color: Colors.grey[850],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => StudyjioDetailScreen(studyjio: joinedJio,) 
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
                              studyjio['title'], 
                              style: TextStyle(
                                fontSize: 17, 
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[300]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Text(
                              studyjio['date'],
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.grey[100]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Text(
                              studyjio['startTime'] + " to " + studyjio['endTime'],
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.grey[100]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Text(
                              studyjio['location'],
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.grey[100]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 20,),
                                Text(
                                  "Current count: ",
                                  style: TextStyle(
                                    fontSize: 14, 
                                    color: Colors.grey[100]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  studyjio['joinedUsers'].values.where((e)=> e as bool).length.toString(),
                                  style: TextStyle(
                                    fontSize: 14, 
                                    color: Colors.grey[100]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  " / ",
                                  style: TextStyle(
                                    fontSize: 14, 
                                    color: Colors.grey[100]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0, bottom: 0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  studyjio['capacity'].toString(),
                                  style: TextStyle(
                                    fontSize: 14, 
                                    color: Colors.grey[100]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                JoinStudyjio(studyjio: joinedJio),
                SizedBox(width: 20,),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}




