// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:SoCUniteTwo/providers/studyjios.dart';
// //import 'package:SoCUniteTwo/widgets/studyjios/studyjio_item.dart';

// class StudyjiosList extends StatelessWidget {
//   final bool showMine;
//   final bool showJoined;

//   StudyjiosList(this.showMine, this.showJoined);

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<Studyjios>(
//       create: (context) => Studyjios(),
//       child: buildStudyjios(context),
//     );
//   }

//    Widget buildStudyjios(context) {
//         final studyjiosData = Provider.of<Studyjios>(context);
//         final studyjios =
//             showMine ? studyjiosData.myStudyjios : studyjiosData.items;
//         return ListView.builder(
//           padding: const EdgeInsets.all(10.0),
//           itemCount: studyjios.length,
//           itemBuilder: (ctx, i) => ChangeNotifierProvider(
//             create: (ctx) => studyjios[i],
//             child: StudyjioItem(),
//                       ),
//                     );
//     }
// }
            
//             StudyjioItem() {
// } 