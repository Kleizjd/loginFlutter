import 'package:flutter/material.dart';
import 'package:flutter_secret_chat/pages/usuarios/user_list.dart';
import 'package:http/http.dart' as http;
import '../../app_config.dart';


class UserEditData extends StatefulWidget {
  final List list;
  final int index;

  UserEditData({this.list, this.index});

  @override
  _UserEditDataState createState() => new _UserEditDataState();
}

class _UserEditDataState extends State<UserEditData> {

  TextEditingController nombre_usuario;
  TextEditingController contrasena;
  TextEditingController roll;



  void editData() {
    print("entra");
    var url ="${AppConfig.apiHost}/Usuarios/editdataUsuarios.php";
    http.post(url,body: {
      "id": widget.list[widget.index]['Id'],
      "nombre_usuario": nombre_usuario.text,
      "contrasena": contrasena.text,
      "roll": roll.text
    });
  }


  @override
  void initState() {
    nombre_usuario= new TextEditingController(text: widget.list[widget.index]['Nombre_Usuario'] );
    contrasena= new TextEditingController(text: widget.list[widget.index]['Contrasena'] );
    roll= new TextEditingController(text: widget.list[widget.index]['Roll'] );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("EDITAR"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: new TextFormField(
                    controller: nombre_usuario,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre de usurio";
                    },
                    decoration: new InputDecoration(
                      hintText: "Usuario", labelText: "Usuario",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.black),
                  title: new TextFormField(
                    controller: contrasena,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa una Contraseña";
                    },
                    decoration: new InputDecoration(
                      hintText: "Contraseña", labelText: "Contraseña",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.settings_input_component, color: Colors.black),
                  title: new TextFormField(
                    controller: roll,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un Nivel";
                    },
                    decoration: new InputDecoration(
                      hintText: "Nivel", labelText: "Nivel",
                    ),
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Guardar"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context)=>new  UserList()));

                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

