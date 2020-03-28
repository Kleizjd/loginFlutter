import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDateTimePiker extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String value;


  CustomDateTimePiker({@required this.onPressed,@required this.icon,@required this.value});

  @override
  Widget build(BuildContext context) {
    return FlatButton(padding: EdgeInsets.zero,
//    return CupertinoButton(padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: <Widget>[
              Icon(icon, color: Theme.of(context).accentColor, size: 30), Text(value, style: TextStyle(fontSize: 14),),
              SizedBox(width: 12,)
            ],
          ),
        )
    );
  }
}
