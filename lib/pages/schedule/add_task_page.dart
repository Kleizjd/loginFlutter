import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/api/schedule_api.dart';
import 'package:flutter_secret_chat/providers/me.dart';
import 'package:flutter_secret_chat/utils/dialogs.dart';
import 'package:flutter_secret_chat/widgets/agenda_interface/custom_date_time_picker.dart';
import 'package:flutter_secret_chat/widgets/agenda_interface/custom_modal_action_button.dart';
import 'package:flutter_secret_chat/widgets/agenda_interface/custom_textfield.dart';
import 'package:intl/intl.dart';


class AddTaskPage extends StatefulWidget {
//  final String userId;
//  const AddTaskPage({this.userId});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _schedule = ScheduleAPI();//Instance
  //////////////////////////////[ DATA USER ]////////////////////////////////
  Me _me;
  var user;

  _scheduleUser(){
    user = _me.data.toJson();
    return user;
  }

  /////////////////////////////////////////////////////////////////////
    String _description;
    DateTime selectedDate;
    DateFormat militarFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      DateFormat formatUTC = DateFormat('YYYY-MM-DDTHH:MM:ss');

  final _textTaskController = TextEditingController();///AUN NO CONOSCO BIEN SU USO
    @override
    void initState() {

//      print('imprimir user id: ${widget.userId}');

      selectedDate= new DateTime.now();
      super.initState();
    }
  //  DateFormat dateFormat = DateFormat('yyyy-MM-dd h:mm a');

  /////////////////////////    PICKERS / CALENDARIO  ///////////////////////////////////////////////////////
  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(seconds: 1)),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),

  );
  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
//      builder: (BuildContext context, Widget child){
//        return MediaQuery(
//          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//          child: child,
//        );
//      },
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
  }
    _setDateSchedule() async{
      final date = await _selectDateTime(context);
      if (selectedDate == null) return;
      setState(() {
        selectedDate = DateTime(
          date.year,
          date.month,
          date.day,
          selectedDate.hour,
          selectedDate.minute,
        );
      });
    }
    _setTimeSchedule() async{
      final time = await _selectTime(context);
      if (time == null) return;

      setState(() {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          time.hour,
          time.minute,
        );
      });
    }
  ////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////[ INSERT SCHEDULE ] ////////////////////////////////////////////////////
  _createSchedule() async {
    var userId = user['_id'].toString();
    var date =  formatUTC.format(selectedDate);
//    var date =  militarFormat.format(selectedDate);
    final isOk = await _schedule.createSchedule(context, userId: userId, description: _description, date: date);
    if(isOk){
      print("schedule created");
      Dialogs.alert(context, message: 'tarea agendada correctamente');
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    _me = Me.of(context);
    _textTaskController.clear();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(child: Text("Anadir tarea ADD_TASK_PAGE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
            SizedBox(height: 12),

            Wrap(
              children: <Widget>[
                ///Calendario
                CustomDateTimePiker(icon: Icons.date_range, onPressed: (){_setDateSchedule();}, value: new DateFormat("dd-MM-yyy").format(selectedDate)),
                ///Reloj
                CustomDateTimePiker(icon: Icons.access_time, onPressed: (){_setTimeSchedule();}, value: new DateFormat("HH:mm:ss").format(selectedDate)),
              ],
            ),

            SizedBox(height: 24),

            CustomTexfield(labelText: "Ingresa el nombre de la tarea", controller: _textTaskController),
            SizedBox(height: 24),
            ///-------[ CLOSE / SAVE  ]--------------///
            CustomModalActionButton(
              ///--[ CLOSE ]--//
              onClose: (){Navigator.of(context).pop();},
              ///--[ SAVE ]--//
             onSave: (){
//           String fecha = militarFomat.format(selectedDate).toString();
               if(_textTaskController.text == ""){
                 print("datos no encontrados");
               } else {
                 _scheduleUser();
                 _description =_textTaskController.text;
                 _createSchedule();
//               provider.insertTodoEntries(new TodoData( id: null,
//                 date: _selectedDate, time: DateTime.now(), task: _textTaskController.text,
//                 description: "", isFinish: false, todoType: TodoType.TYPE_TASK.index,)).whenComplete(()=>Navigator.of(context).pop());
               }
             },
            )
//          _actionButton(context)
          ],
        ),
      ),
    );
  }

}
