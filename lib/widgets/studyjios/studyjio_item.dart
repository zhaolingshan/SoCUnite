// the list item that gets rendered for every studyjio
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:SoCUniteTwo/screens/studyjio_screens/studyjio_detail_screen.dart';
//import 'package:SoCUniteTwo/providers/studyjio.dart';

/* class StudyjioItem extends StatelessWidget {
  /*final String id;
  final String title;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int capacity;
  String location;
  int currentCount; // number of users who joined at any point in time

  StudyjioItem(
    this.id, 
    this.title, 
    this.date, 
    this.startTime, 
    this.endTime, 
    this.capacity, 
    this.location,
    this.currentCount,
    ); */

  @override
  Widget build(BuildContext context) {
    final studyjio = Provider.of<Studyjio>(context);
    return ListTile(
      title: Text(studyjio.title),
      subtitle: Text(studyjio.date.toString() 
                  + studyjio.startTime 
                  + ' to ' + studyjio.endTime 
                  + ' at ' + studyjio.location // first line
                  + 'count: ' + studyjio.currentCount.toString() + '/' + studyjio.capacity.toString() // second line
                ),
      isThreeLine: true,
      selected: true,
      trailing: RaisedButton(
        child: Text(
          studyjio.isJoined? 'JOINED' : 'JOIN'
        ),
        color: studyjio.isJoined? Colors.grey[900] : Colors.red,
        onPressed: () {
          studyjio.toggleJoinStatus();
          // added into chat room but bring user to chatroom directly?
          // disable button so user cant join the same studyjio session again
          // disable button when user already joined AND when currentCount == capacity
          // count shown must increment by 1 
        }
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          StudyjioDetailScreen.routeName, 
          arguments: studyjio.id,
        );
      },  
    );
  }
} */