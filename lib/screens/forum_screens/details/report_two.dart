//import 'package:SoCUniteTwo/screens/forum_screens/CS2030_forum.dart';
import 'package:flutter/material.dart';

class ReportTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Row(children: <Widget>[
            Spacer(),
                  IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName('/modulescreen'));
                        
                      },
                    ),
          ],), 
          SizedBox(height: 40,),                   
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Icon(Icons.beenhere, color: Colors.greenAccent, size: 40,),
          ],),
          Padding(
            padding: EdgeInsets.all(8),
          child:
          Text(
            "Thanks for letting us know",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
           color: Colors.white),
          textAlign: TextAlign.center,),),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Expanded(child: 
            Text(
            "Your feedback is crucial in helping us maintain the quality of posts. Happy learning!",
          style: TextStyle(fontSize: 15,
           color: Colors.grey[500]),
          textAlign: TextAlign.center,),),
           SizedBox(width: 20,),
          ],)      
      ],),
    );
  }
}