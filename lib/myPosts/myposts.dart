import 'package:SoCUniteTwo/myPosts/myposts_collaborations.dart';
import 'package:SoCUniteTwo/myPosts/myposts_forum.dart';
import 'package:SoCUniteTwo/myPosts/myposts_notes.dart';
import 'package:SoCUniteTwo/myPosts/myposts_feedbacks.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/myPosts/myposts_offer.dart';
import 'package:SoCUniteTwo/myPosts/myposts_experiences.dart';
class MyPosts extends StatelessWidget { //display screen for my Posts
//users can click on respective grids t=which will bring them to their posts in thst category
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
        ),
        title: Text("My posts", style: TextStyle(fontSize: 20,)),
        
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MyPostsForums()));
            },
            child:
          Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Icon(Icons.live_help, color: Colors.white, size: 80,),
                  SizedBox(height: 10,),
                  Text("Forums", style: TextStyle(color: Colors.white, 
                  fontWeight: FontWeight.bold, fontSize: 18),),
              ],)
            ,),
          )
          ),
    GestureDetector(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MyPostsNotes()));
            },
            child:
          Container(
            decoration: BoxDecoration( 
              color: Colors.tealAccent[400],
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Icon(Icons.subject, color: Colors.white, size: 80,),
                  SizedBox(height: 10,),
                  Text("Notes", style: TextStyle(color: Colors.white, 
                  fontWeight: FontWeight.bold, fontSize: 18),),
              ],)
            ,),
          ),),
    GestureDetector(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MyPostsFeedbacks()));
            },
            child:
          Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Icon(Icons.feedback, color: Colors.white, size: 80,),
                  SizedBox(height: 10,),
                  Text("Feedback", style: TextStyle(color: Colors.white, 
                  fontWeight: FontWeight.bold, fontSize: 18),),
              ],)
            ,),
          ),),
    GestureDetector(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MyPostsCollaborations()));
            },
            child:
          Container(
            decoration: BoxDecoration(
              color: Colors.green[500],
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Icon(Icons.people, color: Colors.white, size: 80,),
                  SizedBox(height: 10,),
                  Text("Collaborations", style: TextStyle(color: Colors.white, 
                  fontWeight: FontWeight.bold, fontSize: 18),),
              ],)
            ,),
          ),),
    GestureDetector(
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MyPostsOffers()));
            },
            child:
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Icon(Icons.school, color: Colors.white, size: 80,),
                  SizedBox(height: 10,),
                  Text("Internship offers", style: TextStyle(color: Colors.white, 
                  fontWeight: FontWeight.bold, fontSize: 18),),
              ],)
            ,),
          ),),
    GestureDetector(
            onTap: () {
             Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MyPostsExperiences()));
            },
            child:
          Container(
            decoration: BoxDecoration(
              color: Colors.indigo[400],
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Icon(Icons.plus_one, color: Colors.white, size: 80,),
                  SizedBox(height: 10,),
                  Text("SeniorSays", style: TextStyle(color: Colors.white, 
                  fontWeight: FontWeight.bold, fontSize: 18),),
              ],)
            ,),
          )),
      ],),
    );
  }
}