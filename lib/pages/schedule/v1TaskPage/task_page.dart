import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/api/schedule_api.dart';
import 'package:flutter_secret_chat/models/schedule_user.dart';
import 'package:flutter_secret_chat/providers/schedule.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_button.dart';
import 'package:flutter_secret_chat/widgets/notification/local_notifications_helpers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget {
  final userId;

  const TaskPage({Key key, this.userId}) : super(key: key);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  _setScheduleNotification(){
    //  //ANGENDA EL DIA Y LA HORA
//  String selectedDate;
  DateFormat militarFomat = DateFormat('yyyy-MM-dd HH:mm:ss');
//  ////------------- NOTIFICACION en segundo plano para cuando se cumpla la fecha
//    String fecha = militarFomat.format(selectedDate).toString();
//    DateTime now = DateTime.parse(fecha).toUtc();
//    showDateNotification(context, notifications,
//    icon: Image.asset('assets/images/gym.png'),
//    picture: Image.asset('assets/images/picture.jpg'),
//    title: 'Gym',body: 'Es hora del ejercicio', datetime: now, id: 30);
//  //--------------------------------------------------------------------------------//

  }

    final _scheduleAPI = ScheduleAPI();
  ///--------------[ LIST SCHEDULE / LISTA DE HORARIOS]---------------------///
    Schedule _schedule;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScheduleUser>>(
      future: _fetchSchedule(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ScheduleUser> data = snapshot.data;

          return _scheduleListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<ScheduleUser>> _fetchSchedule() async {
      final scheduleResponse = await _scheduleAPI.getScheduleInfo(context, userId: widget.userId);
      final List<dynamic> scheduleJsonList = scheduleResponse;
    return  scheduleJsonList.map((e) => ScheduleUser.fromJson(e)).toList();
  }

  ListView _scheduleListView(_data) {
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
//          return _tile(_data[index].date, _data[index].description, Icons.work);
//          selectedDate = _data[index].date;
          return _data[index].complete ? _tareaCompleta(_data[index].description, _data[index].date): _tareaIncompleta(_data[index].description, _data[index].date);
        });

  }
  Widget _tareaCompleta(String description, String date) {
    var widthSizeBox = 46.0;
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
        child: Row(
          children: <Widget>[
            SizedBox(width: widthSizeBox,),
            Icon(Icons.radio_button_checked, color: Theme.of(context).accentColor, size: 20,),
            SizedBox(width: widthSizeBox,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [BoxShadow( color: Color(0x20000000), blurRadius: 5, offset: Offset(0,3) )]

                  ),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// INFORMACION / INFORMATION SCHEDULE
                      Text(description, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),//tarea
                      SizedBox(height: 12,),
                      Text(date),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: widthSizeBox,),
          ],
        ),
    );
  }

  Widget _tareaIncompleta(String description, String date) {
    var widthSizeBox = 46.0;
    return InkWell(
      onTap: () {
        showDialog(context: context, builder: (context){
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Confirmar tarea", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 24),
                  Text(description),
//                  Text(data.task),

                  SizedBox(height: 24),
                  Text("tiempo"),
                  SizedBox(height: 24),
                  CustomButtom(
                    buttonText: "Completa",
                    onPressed: (){
                      ///implementar base de datos request para completar
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          );
        });
//        //aplica para completar la tarea
      },
      onLongPress: (){
        showDialog(context: context, builder: (context){
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Borrar tarea", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 24),
                  Text(description),
                  SizedBox(height: 24),
                  Text("date"),
                  SizedBox(height: 24),
                  CustomButtom(
                    buttonText: "Borrar",
                    onPressed: (){
//                      dateFormat = DateFormat('yyyy-MM-dd h:mm a');
                      //implementar base de datos request para completar
                    },
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          );
        });
        //aplica para borrar la tarea
      },
      child: Row(
        children: <Widget>[
          SizedBox(width: widthSizeBox,),
          Icon(Icons.radio_button_unchecked, color: Theme.of(context).accentColor, size: 20,),
          SizedBox(width: widthSizeBox,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [BoxShadow( color: Color(0x20000000), blurRadius: 5, offset: Offset(0,3) )]

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// INFORMACION / INFORMATION SCHEDULE
                    Text(description, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),//tarea
                    SizedBox(height: 12,),
                    Text(date),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: widthSizeBox,),
        ],
      )
    );
  }

}