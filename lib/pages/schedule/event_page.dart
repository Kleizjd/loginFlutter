import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_icon_decoration.dart';


class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}
class Event {
  final String time; final String task; final String desc; final bool isFinish;

  const Event(this.time, this.task, this.desc, this.isFinish);
}
final List<Event> _eventList = [
  new Event ("08:00","llama a Jose para la cita","Personal",true),
  new Event ("08:00","compra el carro","Trabajo",true),
  new Event ("10:00","Arreglar asunto con el desarrollador","Oficina",false),
  new Event ("11:00","Negocios realizados correctamente","Personal", true),
  new Event ("11:00","Negocios realizados correctamente","Personal", true),
  new Event ("11:00","Negocios realizados correctamente","Personal", true),
  new Event ("11:00","Negocios realizados correctamente","Personal", true),
  new Event ("11:00","Negocios realizados correctamente","Personal", true),
];
class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    return ListView.builder(itemCount: _eventList.length, padding: const EdgeInsets.all(0),
    itemBuilder: (context,index) {
      return Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24),
        child: Row(
          children: <Widget>[
            //[ DECORACION ] Linea donde estan ubicados los puntos de cada tarea
            _lineStyle(context, iconSize, index, _eventList.length, _eventList[index].isFinish),
            _displayTime(_eventList[index].time),
            _displayContent(_eventList[index]),

          ],
        ),
      );
    });
  }

  Widget _lineStyle(BuildContext context,double iconSize, int index, int listLength, bool isFinish) {
    return Container(
        decoration: CustomIconDecoration(
          iconSize: iconSize,
          lineWidth: 4,
          firstData: index == 0 ?? true,
          lastData: index == listLength-1 ?? true,
          colorLine: Theme.of(context).accentColor,
        ),
        child: Container( decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), boxShadow: [BoxShadow(offset: Offset(0,3), color: Color(0x20000000), blurRadius: 5)]),
            child: Icon( isFinish ? Icons.fiber_manual_record: Icons.radio_button_unchecked, size: iconSize, color: Theme.of(context).accentColor))
    );
  }

  Widget _displayTime(String time) {
      return Container(width: 80,child: Padding( padding: const EdgeInsets.all(8.0), child: Text(time),));//tiempo
    }

  Widget _displayContent(Event event) {
    return Expanded(
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
              Text(event.task),//tarea
              SizedBox(height: 12,),
              Text(event.desc),// descripcion

            ],
          ),
        ),
      ),
    );
  }
}

