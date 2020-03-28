import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_detail.dart';
import 'registration_data_user.dart';
import '../../app_config.dart';
import 'dart:convert';

//LISTAR USUARIOS

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  Future<List> getData() async {
//    final response = await http.get("${AppConfig.apiHost}/Usuarios/getdataUsuarios.php");
    final response = await http.get("${AppConfig.apiHost}/getdataUsuarios.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de Usuarios"),
//        automaticallyImplyLeading: false,
      ),
      
      //Icono para dar agregar a un nuevo usuario
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => RegistrationDataUser(),
          ));
        },
      ),

      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? new ItemList(list: snapshot.data,): new Center( child: new CircularProgressIndicator(),  );
        },
      ),
    );
  }
}

// USUARIOS GUARDADOS
// parte grafica que se enecargara de pintar los usuarios
class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute( builder: (BuildContext context) => UserDetail( list: list,index: i, ),
                ),
              ),
              child: Card(
                  child: ListTile(
                    title: Text(list[i]['Nombre_Usuario'],style: TextStyle(fontSize: 20, color: Colors.orangeAccent),),
                    leading: Icon(Icons.person, size: 68.0, color: Colors.orangeAccent),
                    subtitle: Text("Nivel: ${list[i]['Roll']}", style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              )),

            ),
          );
        }
    );
  }
}
