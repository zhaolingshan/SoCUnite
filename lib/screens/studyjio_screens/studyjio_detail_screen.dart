// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:SoCUniteTwo/providers/studyjios.dart';

// class StudyjioDetailScreen extends StatelessWidget {

// /*StudyjioDetailScreen(
//   this.title, 
//   //this.description
// );*/

//   static const routeName = '/studyjio-detail';

//   @override
//   Widget build(BuildContext context) {
//     final studyjioId = ModalRoute.of(context).settings.arguments as String; // is the id
//     final loadedStudyjio = Provider.of<Studyjios>(
//       context,
//       listen: false,
//       )
//       .findbyId(studyjioId);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(loadedStudyjio.title),
//       ),  
//     );
//   }
// }