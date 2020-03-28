import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/models/schedule_user.dart';
import 'package:provider/provider.dart';

class Schedule extends ChangeNotifier{

  ScheduleUser _data;

  get data =>_data;

  set data(ScheduleUser user){
    this._data=user;
    notifyListeners();
  }

  static Schedule of(BuildContext context)=>Provider.of<Schedule>(context);
}