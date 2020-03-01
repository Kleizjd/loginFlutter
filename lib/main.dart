import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secret_chat/pages/home.dart';
import 'package:flutter_secret_chat/pages/agenda/agenda_home.dart';
import 'package:flutter_secret_chat/pages/splash.dart';
//import 'pages/login.dart';
import 'pages/login_user.dart';
import 'pages/sign_up.dart';
import 'package:flutter_secret_chat/providers/me.dart';
import 'package:provider/provider.dart';

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
//        ///////////--------------------[ CAMBIO DE IDIOMA DE INGLES ]------------------------------------//////////
        supportedLocales: [ const Locale('en','US'), const Locale('es','ES')],
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
//        AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
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
          "home":(context)=>AgendaHome(),
//        "login":(context)=>LoginPage(),
//        "home":(context)=>HomePage(),
//        "Header": (context)=>Header(),
        },
      ),
    );
  }
}


