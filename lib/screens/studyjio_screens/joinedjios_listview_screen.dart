import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

//import 'package:SoCUniteTwo/providers/studyjios.dart';
//import 'package:SoCUniteTwo/widgets/studyjios/joinstudyjio.dart';

class JoinedjiosListviewScreen extends StatefulWidget {

  @override
  _JoinedjiosListviewScreenState createState() => _JoinedjiosListviewScreenState();
}

class _JoinedjiosListviewScreenState extends State<JoinedjiosListviewScreen> {

  String checkDate(String dateString) {

   DateTime checkedTime= DateTime.parse(dateString);
   DateTime currentTime= DateTime.now();

   if((currentTime.year == checkedTime.year)
          && (currentTime.month == checkedTime.month)
              && (currentTime.day == checkedTime.day)) {
        return "Today";
    }
   else if((currentTime.year == checkedTime.year)
              && (currentTime.month == checkedTime.month)) {
    if ((currentTime.day - checkedTime.day) == -1) {
      return "Tomorrow";
    } else {
      return DateFormat.MMMMd().format(DateTime.now());
    }
}

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey[900],
      body: Container(),
  );
  }
}



