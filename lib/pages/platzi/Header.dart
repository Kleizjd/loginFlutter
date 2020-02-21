import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BackWeather.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      child: Container(
        margin: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20,
        ),
        height: 50.0,
        width: 180.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFf38B02),
              offset: Offset(10.0, 10.0),
              blurRadius: 30.0,
            )
          ],
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFFfeb800),
        ),
        child: Center(
          child: Text(
            "Hello everyone",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[

          BackWeather(),
          Positioned(
            left: 10,
            top: 15,
            child: SafeArea(
              child: CupertinoButton(
                padding: EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(30),
                color: Colors.black12,
                onPressed:()=>Navigator.pop(context),
                child: Icon(Icons.arrow_back, color: Colors.white,),),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Miercoles",
                  style: const TextStyle(
                      fontSize: 55.0,
                      color: Color(0xFFeba500),
                      fontWeight: FontWeight.w600),
                ),
                button,

              ],

            ),

          )

        ],
      ),

    );
  }
}
