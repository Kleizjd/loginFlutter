import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import '../utils/dialogs.dart';
import '../app_config.dart';

class ScheduleAPI {
  Future<bool> createSchedule(BuildContext context,{@required String userId, @required description, @required String date}) async {
    try {
      final url = "${AppConfig.apiHost}/users/createSchedule";
      print('Datos a ingresar : $userId, $description,  $date');
      final response = await http.post(url, body: {"userId": userId, "description": description, "date": date });

      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 403) {
        throw PlatformException(code: "403", message: parsed['message']);
      } else if (response.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      }
      throw PlatformException(code: "201", message: "error: /createSchedule");
    } on PlatformException catch (e) {
      print("error createSchedule: ${e.message}");
      Dialogs.alert(context, title: "ERROR", message: e.message);
      return null;
    }
  }

  Future<dynamic> getScheduleInfo(BuildContext context, {@required String userId}) async {

    try {
      final url = "${AppConfig.apiHost}/users/getUserSchedule";

      final response = await http.post(url, body: {"userId": userId});
      final parsed = jsonDecode(response.body);


      if (response.statusCode == 200) {
        return parsed;
      } else if (response.statusCode == 403) {
        throw PlatformException(code: "403", message: parsed['message']);
      } else if (response.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      }
      throw PlatformException(code: "201", message: "error: /Schedule");
    } on PlatformException catch (e) {
      print("error getUserInfo: ${e.message}");
      Dialogs.alert(context, title: "ERROR", message: e.message);
      return null;
    }
  }
  Future<bool> deleteSchedule(BuildContext context,{@required String userId, @required description, @required String date}) async {
    try {
      final url = "${AppConfig.apiHost}/users/deleteSchedule";
      print('Datos a ingresar : $userId, $description,  $date');
      final response = await http.post(url, body: {"userId": userId, "description": description, "date": date });

      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 403) {
        throw PlatformException(code: "403", message: parsed['message']);
      } else if (response.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      }
      throw PlatformException(code: "201", message: "error: /createSchedule");
    } on PlatformException catch (e) {
      print("error createSchedule: ${e.message}");
      Dialogs.alert(context, title: "ERROR", message: e.message);
      return null;
    }
  }
  Future<bool> updateSchedule(BuildContext context,{@required String userId, @required description, @required String date}) async {
    try {
      final url = "${AppConfig.apiHost}/users/updateSchedule";
      print('Datos a ingresar : $userId, $description,  $date');
      final response = await http.post(url, body: {"userId": userId, "description": description, "date": date });

      final parsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 403) {
        throw PlatformException(code: "403", message: parsed['message']);
      } else if (response.statusCode == 500) {
        throw PlatformException(code: "500", message: parsed['message']);
      }
      throw PlatformException(code: "201", message: "error: /createSchedule");
    } on PlatformException catch (e) {
      print("error createSchedule: ${e.message}");
      Dialogs.alert(context, title: "ERROR", message: e.message);
      return null;
    }
  }
}
