
import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_date_time_picker.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_modal_action_button.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_textfield.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  /////////////////////////    PICKERS  ///////////////////////////////////////////////////////
  String _selectedDate = "Seleccionar fecha";
  TimeOfDay  _selectedTime;
  //CALENDARIO
  Future _pickDate() async{
    DateTime datepick = await showDatePicker(context: context, initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if(datepick != null){
      setState(() {
        _selectedDate = datepick.toString();
      });
    }
  }
  Future _pickTime() async{
     TimeOfDay timepick = await showTimePicker(context: context, initialTime: TimeOfDay.now());
     if(timepick != null) {
       setState(() {
//         _selectedTime = timepick.toString();
         _selectedTime = timepick.replacing(hour: timepick.hourOfPeriod);

       });
     }
  }


  ////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text("Anadir nuevo evento", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
          SizedBox(height: 24),
          CustomTexfield(labelText: "Ingresa el nombre del evento"),
          SizedBox(height: 12),
          CustomTexfield(labelText: "Descripcion"),
          SizedBox(height: 12),
          ///Calendario
          CustomDateTimePiker(icon: Icons.date_range, onPressed: _pickDate, value: _selectedDate),
          ///Reloj
          CustomDateTimePiker(icon: Icons.access_time, onPressed: _pickTime, value: _selectedTime.toString()),


          SizedBox(height: 24),
          ///BOTONES CERRAR Y GUARDAR
          CustomModalActionButton(onClose: (){Navigator.of(context).pop();},onSave: (){},)

        ],
      ),
    );

  }
}
