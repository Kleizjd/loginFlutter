
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_secret_chat/api/schedule_api.dart';
import 'package:flutter_secret_chat/models/schedule_user.dart';
import '../models/user.dart';
import '../api/auth_api.dart';
import '../api/profile_api.dart';
import '../providers/me.dart';
import '../providers/schedule.dart';
import 'dart:async';
import 'package:logger/logger.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authAPI = AuthAPI();
  final _profileAPI = ProfileAPI();
  final _scheduleAPI = ScheduleAPI();

  List<Schedule> _scheduleList  = new List<Schedule>();
  Schedule _schedule;
  Me _me;

  @override
  void initState() {
    super.initState();

    this.check();
  }

  check() async {
    final token = await _authAPI.getAccessToken();

    if (token != null) {
      final result = await _profileAPI.getUserInfo(context, token);

      print(result);
//      print(result.toString());
      final user = User.fromJson(result);
      print('user $user');
      _me.data = user;
      print('_me.data $_me.data');
//      //---------------------[ SCHEDULE DATA USER ]----------------------------------------//
        var userId = _me.data.toJson();
      userId = userId['_id'] as String;

//      final scheduleResponse = await _scheduleAPI.getScheduleInfo(context, userId: userId);
//      final List<dynamic> scheduleJsonList = scheduleResponse;
////      final listSchedule = scheduleJsonList.map((e) => ScheduleUser.fromJson(e)).toBuiltList();
//      final listSchedule = scheduleJsonList.map((e) => ScheduleUser.fromJson(e)).toBuiltList();
//
//      print('scheduleResponse');
//      print(scheduleResponse);
//      print('listSchedule');
//      print(listSchedule);
////      final todosJsonList2 =  listSchedule.map((e) => e.toJson()).toList();
////      final todosJson2 = json.encode(todosJsonList2);
////      _schedule.data = todosJson2;
//      for(var data in listSchedule){
//        _schedule.data = data;
//        _scheduleList.add(_schedule.data);
//
//      }
////      _schedule.data = ;
////      print(_schedule.data);
//
////      _schedule.data = scheduleJsonList.map((e) => ScheduleUser.fromJson(e)).toBuiltList();
//
////      //---------------------[        END         ]----------------------------------------//



      Navigator.pushReplacementNamed(context, "home");
    } else {
      Navigator.pushReplacementNamed(context, "login");
    }
  }
///INDICADOR CARGANDO
  @override
  Widget build(BuildContext context) {
//    _scheduleList = Schedule.of(context);
//    _scheduleList;
//    _schedule
    _me = Me.of(context);

    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(radius: 15),
      ),
    );
  }
}