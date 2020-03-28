//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:flutter_secret_chat/models/schedule_user.dart';
//
//
//class Schedule extends ChangeNotifier{
//
//  ScheduleUser _data;
//
//  get data =>_data;
//
//  set data(ScheduleUser schedule){
//    this._data=schedule;
//    notifyListeners();
//  }
//
//  static Schedule of(BuildContext context)=>Provider.of<Schedule>(context);
//}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/schedule_user.dart';

class Schedule extends ChangeNotifier{

  ScheduleUser _data;

  get data =>_data;

  set data(ScheduleUser user){
    this._data=user;
    notifyListeners();
  }

  static Schedule of(BuildContext context)=>Provider.of<Schedule>(context);
}