import 'package:flutter/material.dart';

class UserStudyJio extends StatelessWidget {
  final String id;
  final String title;
  final String dateAndTime;
  final String count;

  UserStudyJio(this.id, this.title, this.dateAndTime, this.count);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(dateAndTime),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: () {
              //Navigator.of(context).pushNamed(EditStudyJio.routeName, arguments: id);
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete), 
            onPressed: () {}, 
            color: Theme.of(context).errorColor,
          ),
          ],
        ),
      ),  
    );
  }
}
