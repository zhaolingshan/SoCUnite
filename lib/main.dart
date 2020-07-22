//import 'package:SoCUniteTwo/screens/forums.dart';
import 'package:SoCUniteTwo/screens/forum_screens/collaborations/collaborations.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/views/first_view.dart';
import 'package:SoCUniteTwo/services/auth_service.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/views/sign_up_view.dart';
import 'package:SoCUniteTwo/screens/bottomnavigation.dart';
import 'package:SoCUniteTwo/screens/profile.dart';
import 'package:SoCUniteTwo/screens/passwordchange.dart';
import 'package:SoCUniteTwo/screens/timetable.dart';
import 'package:SoCUniteTwo/screens/modules.dart';
import 'package:SoCUniteTwo/screens/forum_screens/module_screen.dart';
import 'package:SoCUniteTwo/myPosts/myposts.dart';
import 'package:SoCUniteTwo/screens/forum_screens/internship_offers/offers.dart';
import 'package:SoCUniteTwo/screens/forum_screens/experiences/experiences.dart';
import 'package:SoCUniteTwo/screens/settings.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoCUnite',
      theme: ThemeData(
        //primaryColor: PrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeController(),
      routes: <String, WidgetBuilder> {
        '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp,),
        '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn,),
        '/home': (BuildContext context) => HomeController(),
        '/begin': (BuildContext context) => FirstView(),
        '/profile': (BuildContext context) => Profile(),
        '/passwordchange': (BuildContext context) => PasswordChange(),
        '/timetable': (BuildContext context) => Timetable(),
        '/modules': (BuildContext context) => Modules(),
        '/modulescreen': (BuildContext context) => ModuleScreen(),
        '/myposts': (BuildContext context) => MyPosts(),
        '/collaborations': (BuildContext context) => Collaborations(),
        '/offers': (BuildContext context) => Offers(),
        '/experiences': (BuildContext context) => Experiences(),
        '/settings': (BuildContext context) => Settings(),
      },
    )
  );
  }
}

    

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? BottomNavigation() : FirstView();
        }
        return CircularProgressIndicator();
      }
    );
  }
}




