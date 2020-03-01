import 'package:flutter/material.dart';
class CustomTexfield extends StatelessWidget {
  final String labelText;


  CustomTexfield({@required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration( border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(12))),
          labelText: labelText ),
    );
  }
}
