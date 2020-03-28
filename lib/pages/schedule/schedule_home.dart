import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/utils/dialogs.dart';
import 'package:flutter_secret_chat/utils/session.dart';
import 'package:flutter_secret_chat/widgets/schedule_interface/custom_button.dart';

/// SCHEDULE INTERFACE ///

import 'package:flutter_secret_chat/widgets/menu_ejercicios.dart';
import 'package:flutter_secret_chat/widgets/carrusel.dart';
//import 'task_page.dart';
import 'v1TaskPage/task_page.dart';
import 'add_event_page.dart';
import 'add_task_page.dart';
import 'event_page.dart';

///PROVIDERS
import 'package:flutter_secret_chat/providers/me.dart';


class ScheduleHome extends StatefulWidget {
  @override
  _ScheduleHomeState createState() => _ScheduleHomeState();
}

class _ScheduleHomeState extends State<ScheduleHome> {
  //////////////////////////////////////////////////////////////////////
  Me _me;
  var user;

 _scheduleUser(){
    user = _me.data.toJson();
    return user;
  }
  @override
  void initState() {

    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _onExit() {
    Dialogs.confirm(context, title: "COFIRM", message: "Are you sure?",
        onCancel: () {
          Navigator.pop(context);
        }, onConfirm: () async {
          Navigator.pop(context);
          Session session = Session();
          await session.clear();
          Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => false);
        });
  }
  ///////////////////////////////////////////////////////////////////////




  PageController _pageController = PageController();
  double currentPage = 0;
  @override
  Widget build(BuildContext context) {
    _me = Me.of(context);

    _pageController.addListener((){
      setState(() {
        currentPage = _pageController.page;
      });
    });
    return Scaffold(
//      appBar: AppBar(
//        title: Text("retroceso"),
//      ),
      //BOTTON CENTRADO INFERIOR PANTALLA
      body: Stack(children: <Widget>[
//        Container(height:35,color: Theme.of(context).accentColor,),

        Positioned( right: 0, child: Text("6", style: TextStyle(fontSize: 200, color: Color(0x10000000)))),
        _mainContent(context),
      ],
      ),
//      body: _mainContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              barrierDismissible: false, context: context,
              builder: (BuildContext context){
                return Dialog(
//                  child: currentPage == 1 ? AddEventPage(): AddTaskPage(context, userId: user['userId'].toString(),),
                  child: currentPage == 1 ? AddEventPage(): AddTaskPage(),
                  //                  child: AddTaskPage(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                );
              }
          );
        },
        child: Icon(Icons.add),
      ),
      //CENTRA EL BOTON FLOTANTE Y LE HACE DISENO BORDEADO
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //BOTON DE HERRAMIENTAS
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){

                        return CarouselDemo();
//                        return MenuEjercicios();
                      }
                  );

                }),
              _menuOption(context),
//            IconButton(
//                icon: Icon(Icons.more_vert),
//                onPressed: (){}),
          ],
        ),
      ),

    );
  }
  ///BOTONES TAREAS Y EVENTOS
  Widget _button(BuildContext context){
    return Row(
      children: <Widget>[
        Expanded( child: CustomButtom(onPressed: (){ _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);},
            buttonText: "Tareas",
            color: currentPage < 0.5 ? Theme.of(context).accentColor : Colors.white,
            textColor:  currentPage < 0.5 ? Colors.white : Theme.of(context).accentColor,
            borderColor: currentPage < 0.5 ? Colors.transparent :Theme.of(context).accentColor)),
        SizedBox(width: 32,),
        Expanded( child: CustomButtom(onPressed: (){_pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.bounceInOut);},
            buttonText: "Eventos",
            color: currentPage > 0.5 ? Theme.of(context).accentColor : Colors.white ,
            textColor:  currentPage > 0.5 ? Colors.white : Theme.of(context).accentColor,
            borderColor: currentPage > 0.5 ? Colors.transparent :Theme.of(context).accentColor)),
      ],
    );
  }

  /// CONTENIDO PRINCIPAL DE LA AGENDA /MAIN SCHEDULE CONTENT
  Widget _mainContent(context) {
    _scheduleUser();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(user['username'].toString(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
//            child: Text(user['username'].toString(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(context),
        ),
        Expanded(child: PageView(
          controller: _pageController,
          children: <Widget>[TaskPage(userId: user['_id'].toString(),), EventPage()],))
//          children: <Widget>[TaskPage()],))
      ],
    );
  }
  ///SALIR / EXIT
  Widget _menuOption(context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      onSelected: (String value) {
        if (value == "exit") {
          _onExit();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "share",
          child: Text("Share App"),
        ),
        PopupMenuItem(
          value: "exit",
          child: Text("Exit App"),
        )
      ],
    );
  }
}

