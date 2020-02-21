import 'package:flutter/material.dart';

class BackWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[
          new GradientBack(),
          new Positioned(
            bottom: 0.0,
              child: new Container(
                width: MediaQuery.of(context).size.width,
                height: 225.0,
                color: Colors.white

              ),
          )
        ],
    );
  }
}
class GradientBack extends StatefulWidget {
  @override
  _GradientBackState createState() => _GradientBackState();
}

class _GradientBackState extends State<GradientBack> {
  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
         gradient: new LinearGradient(
             colors: [
               Color(0xFFffbb00), Color(0xFFf38c02), Colors.pink
             ],
           begin: const FractionalOffset(1.0, 0.1),
           end: const FractionalOffset(1.0, 0.9),
         )),
    );
  }
}
