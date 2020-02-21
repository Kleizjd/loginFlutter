import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/pages/home.dart';
import 'package:flutter_secret_chat/pages/splash.dart';
import 'pages/login.dart';
import 'pages/sign_up.dart';
import 'package:flutter_secret_chat/providers/me.dart';
import 'package:provider/provider.dart';
import 'pages/platzi/Header.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => Me(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
//      home: LoginPage(),
        home: SplashPage(),
        routes: {
          "login":(context)=>LoginPage(),
          "splash":(context)=>SplashPage(),
          "signup":(context)=>SignUpPage(),
          "home":(context)=>HomePage(),
//        "Header": (context)=>Header(),


        },
      ),
    );
  }
}


