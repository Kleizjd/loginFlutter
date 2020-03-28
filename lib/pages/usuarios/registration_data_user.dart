import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../app_config.dart';

class RegistrationDataUser extends StatefulWidget {
  @override
  _RegistrationDataUserState createState() => new _RegistrationDataUserState();
}

class _RegistrationDataUserState extends State<RegistrationDataUser> {
  TextEditingController nombre_usuario = new TextEditingController();
  TextEditingController contrasena = new TextEditingController();

  var _formKey = GlobalKey<FormState>();

  void registroDatosUsuario() {
    var url ="${AppConfig.apiHost}/Usuarios/addDataUsuarios.php";

    http.post(url, body: {
      "nombre_usuario": nombre_usuario.text,
      "contrasena": contrasena.text,
      "roll": _mySelection.toString(), //aqui traemos el DropdownMenuItem lo llamamos _mySelection este es como el controller
    });
  }

  String _mySelection;
  List<Map> _myJson = [{"id":0,"name":"cliente"},{"id":1,"name":"administrador"}];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Adicionar Usuarios"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
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
                        hintText: "Usurio", labelText: "Usuario",
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
                  Row(
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Icon(Icons.list),
                      ),
                      VerticalDivider(width: 40.0,),
                      new Container(
                        //margin: EdgeInsets.only(right: 80.0),
                        height: 50.0,
                        width: 150.0,
                        padding: EdgeInsets.only(top: 10),
                        child: new DropdownButton<String>(
                          isDense: true,
                          hint: new Text("Nivel"),
                          iconSize: 40.0,
                          elevation: 10,
                          value: _mySelection,
                          onChanged: (String newValue) {
                            setState(() {
                              _mySelection = newValue;
                            });
                            print (_mySelection);
                          },
                          items: _myJson.map((Map map) {
                            return new DropdownMenuItem<String>(
                              //value: map["id"].toString(),
                              value: map["name"].toString(),
                              child: new Text(
                                map["name"],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(30.0),
                  ),
                  new RaisedButton(
                    child: new Text("Agregar"),
                    color: Colors.blueAccent,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        registroDatosUsuario();
                        Navigator.pop(context);
                      }
                    },
                  ),
                  new RaisedButton(
                    child: new Text("Salir"),
                    color: Colors.blueAccent,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/homePage');
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}