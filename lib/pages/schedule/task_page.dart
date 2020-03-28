
import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/api/schedule_api.dart';
import 'package:flutter_secret_chat/models/schedule_user.dart';
import 'package:flutter_secret_chat/providers/me.dart';
import 'package:flutter_secret_chat/providers/schedule.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_button.dart';
import 'package:flutter_secret_chat/widgets/notification/local_notifications_helpers.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../../app_config.dart';
import 'dart:convert';

class TaskPage extends StatefulWidget {
  final userId;

  const TaskPage({Key key, this.userId}) : super(key: key);
  @override
  _TaskPageState createState() => _TaskPageState();
}
class Task {

    final String task;
    final bool isFinish;
    const Task(this.task, this.isFinish);
}
final List<Task> _taskList =[
//  new Task(task, isFinish)
  new Task ("llama a Jose para la cita",false),
  new Task ("llama a Jose TASK PAGE",false),
  new Task ("Arreglar asunto con el desarrollador",false),
  new Task ("Negocios realizados correctamente", true),
  new Task ("Negocios realizados correctamente", true),
  new Task ("Negocios realizados correctamente", true),
  new Task ("Negocios realizados correctamente", true),
  new Task ("Negocios realizados correctamente", true),

];

class _TaskPageState extends State<TaskPage> {

  @override
  Widget build(BuildContext context) {
//    return ListView.builder(
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: _taskList.length,
        itemBuilder: (context, index){
          return _taskList[index].isFinish ? _tareaCompleta(_taskList[index].task): _tareaIncompleta(_taskList[index]);
        });
  }
  Widget _tareaCompleta(String tarea) {
    return Container(
      foregroundDecoration: BoxDecoration(color: Color(0x60FDFDFD)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.radio_button_checked, color: Theme.of(context).accentColor, size: 20,),
            SizedBox(width: 28,),
            Text(tarea),
          ],
        ),
      ),
    );
  }

  Widget _tareaIncompleta(Task data) {
//  Widget _tareaIncompleta(Task data) {
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
                Text(data.task),
                SizedBox(height: 24),
                Text("tiempo"),
                SizedBox(height: 24),
                CustomButtom(
                  buttonText: "Completa",
                  onPressed: (){
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
                  Text(data.task),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.radio_button_unchecked, color: Theme.of(context).accentColor, size: 20,),
            SizedBox(width: 28,),
            Text(data.task),
          ],
        ),
      ),
    );
  }
}
