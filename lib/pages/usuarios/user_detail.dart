import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_edit_data.dart';
import 'user_list.dart';
import '../../app_config.dart';


class UserDetail extends StatefulWidget {
  List list;
  int index;
  UserDetail({this.index,this.list});
  @override
  _UserDetailState createState() => new _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {

  void borrarDato(){
    var url = "${AppConfig.apiHost}/Usuarios/deleteDataUsuarios.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['Id']
    });
  }

  void confirm (){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Esta seguro de eliminar '${widget.list[widget.index]['Nombre_Usuario']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("OK Eliminado!",style: new TextStyle(color: Colors.black),),
          color: Colors.red,
          onPressed: (){
            borrarDato();
            Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context)=> new UserList(),
                )
            );
          },
        ),
        new RaisedButton(
          child: new Text("CANCELAR",style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: ()=> Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['Nombre_Usuario']}")),
      body: new Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['Nombre_Usuario'], style: new TextStyle(fontSize: 20.0),),
                Divider(),
                new Text("Nivel : ${widget.list[widget.index]['Roll']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("EDITAR"),
                      color: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: ()=>Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context)=>new UserEditData(list: widget.list, index: widget.index,),
                          )
                      ),
                    ),
                    VerticalDivider(),
                    new RaisedButton(
                      child: new Text("ELIMINAR"),
                      color: Colors.redAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: ()=>confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
