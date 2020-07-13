import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:SoCUniteTwo/widgets/provider_widget.dart';
// import 'package:SoCUniteTwo/screens/forum_screens/post.dart';
// import 'package:SoCUniteTwo/screens/forum_screens/details/forum_details.dart';
import 'package:SoCUniteTwo/home_saved/saved_forums.dart';
import 'package:SoCUniteTwo/home_saved/saved_notes.dart';
import 'package:SoCUniteTwo/home_saved/saved_feedbacks.dart';
import 'package:SoCUniteTwo/home_saved/saved_collaborations.dart';
import 'package:SoCUniteTwo/home_saved/saved_offers.dart';
import 'package:SoCUniteTwo/home_saved/saved_experiences.dart';



List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(2, 3),
  const StaggeredTile.count(2, 3),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
];

List<Widget> _tiles = const <Widget>[
  const _Example01Tile(Color(0xFFEF5350), Text("Forums", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)), //Icons.live_help, 
  const _Example01Tile(Color(0xFF00897B), Text("Notes",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)), //Icons.subject, 
  const _Example01Tile(Colors.lightGreen, Text("Feedbacks", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))), // Icons.feedback,
  const _Example01Tile(Colors.pink,  Text("Collaborations", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))), //Icons.people,
  const _Example01Tile(Color(0xFF7E57C2),  Text("Internship Offers", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))), //Icons.school,
  const _Example01Tile(Color(0xFF0288D1), Text("SeniorSays", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))), // Icons.plus_one,
];

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.text); //this.iconData

  final Color backgroundColor;
  //final IconData iconData;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {
          if (backgroundColor == Color(0xFFEF5350)) {
             Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SavedForums()));
          }
          if(backgroundColor == Color(0xFF00897B)) {
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SavedNotes()));
          }
          if(backgroundColor == Colors.lightGreen) {
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SavedFeedbacks()));
          }
          if(backgroundColor == Colors.pink) {
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SavedCollaborations()));
          }
          if(backgroundColor == Color(0xFF7E57C2)) {
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SavedOffers()));
          }
          if(backgroundColor == Color(0xFF0288D1)) {
            Navigator.push(context, 
              MaterialPageRoute(builder: (context) => SavedExperiences()));
          }
        },
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            //   Icon(
            //   iconData,
            //   color: Colors.white,
            //   size: 30,
            // ),
            SizedBox(height: 5,),
            text,
            ],) 
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: new AppBar(
          backgroundColor: Colors.grey[850],
          title: new Text('Saved Posts'),
        ),
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            )));
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.grey[900],
  //     appBar: AppBar(
  //       backgroundColor: Colors.grey[850],
  //       leading: Builder(
  //         builder: (BuildContext context) {
  //           return IconButton(
  //             icon: Icon(Icons.arrow_back),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           );
  //         },
  //       ),
  //       title: Text("Home: Saved posts", style: TextStyle(fontSize: 20,)),
        
  //     ),
  //     body: GridView.count(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 10,
  //       mainAxisSpacing: 10,
  //       padding: const EdgeInsets.all(20),
  //       children: <Widget>[
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.push(context, 
  //             MaterialPageRoute(builder: (context) => SavedForums()));
  //           },
  //           child:
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.red[400],
  //             borderRadius: BorderRadius.all(Radius.circular(20))
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: Center(
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(height: 20,),
  //                 Icon(Icons.live_help, color: Colors.white, size: 80,),
  //                 SizedBox(height: 10,),
  //                 Text("Forums", style: TextStyle(color: Colors.white, 
  //                 fontWeight: FontWeight.bold, fontSize: 18),),
  //             ],)
  //           ,),
  //         )
  //         ),
  //   GestureDetector(
  //           onTap: () {
  //             Navigator.push(context, 
  //             MaterialPageRoute(builder: (context) => SavedNotes()));
  //           },
  //           child:
  //         Container(
  //           decoration: BoxDecoration( 
  //             color: Colors.teal[600],
  //             borderRadius: BorderRadius.all(Radius.circular(20))
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: Center(
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(height: 20,),
  //                 Icon(Icons.subject, color: Colors.white, size: 80,),
  //                 SizedBox(height: 10,),
  //                 Text("Notes", style: TextStyle(color: Colors.white, 
  //                 fontWeight: FontWeight.bold, fontSize: 18),),
  //             ],)
  //           ,),
  //         ),),
  //   GestureDetector(
  //           onTap: () {
  //             Navigator.push(context, 
  //             MaterialPageRoute(builder: (context) => SavedFeedbacks()));
  //           },
  //           child:
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.pink,
  //             borderRadius: BorderRadius.all(Radius.circular(20))
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: Center(
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(height: 20,),
  //                 Icon(Icons.feedback, color: Colors.white, size: 80,),
  //                 SizedBox(height: 10,),
  //                 Text("Feedback", style: TextStyle(color: Colors.white, 
  //                 fontWeight: FontWeight.bold, fontSize: 18),),
  //             ],)
  //           ,),
  //         ),),
  //   GestureDetector(
  //           onTap: () {
  //             Navigator.push(context, 
  //             MaterialPageRoute(builder: (context) => SavedCollaborations()));
  //           },
  //           child:
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.lightGreen,
  //             borderRadius: BorderRadius.all(Radius.circular(20))
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: Center(
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(height: 20,),
  //                 Icon(Icons.people, color: Colors.white, size: 80,),
  //                 SizedBox(height: 10,),
  //                 Text("Collaborations", style: TextStyle(color: Colors.white, 
  //                 fontWeight: FontWeight.bold, fontSize: 18),),
  //             ],)
  //           ,),
  //         ),),
  //   GestureDetector(
  //           onTap: () {
  //             Navigator.push(context, 
  //             MaterialPageRoute(builder: (context) => SavedOffers()));
  //           },
  //           child:
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.lightBlue[800],
  //             borderRadius: BorderRadius.all(Radius.circular(20))
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: Center(
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(height: 20,),
  //                 Icon(Icons.school, color: Colors.white, size: 80,),
  //                 SizedBox(height: 10,),
  //                 Text("Internship offers", style: TextStyle(color: Colors.white, 
  //                 fontWeight: FontWeight.bold, fontSize: 18),),
  //             ],)
  //           ,),
  //         ),),
  //   GestureDetector(
  //           onTap: () {
  //            Navigator.push(context, 
  //             MaterialPageRoute(builder: (context) => SavedExperiences()));
  //           },
  //           child:
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.yellow[600],
  //             borderRadius: BorderRadius.all(Radius.circular(20))
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: Center(
  //             child: Column(
  //               children: <Widget>[
  //                 SizedBox(height: 20,),
  //                 Icon(Icons.plus_one, color: Colors.white, size: 80,),
  //                 SizedBox(height: 10,),
  //                 Text("SeniorSays", style: TextStyle(color: Colors.white, 
  //                 fontWeight: FontWeight.bold, fontSize: 18),),
  //             ],)
  //           ,),
  //         )),
  //     ],),
  //   );
  // }

}

