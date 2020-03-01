import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/api/auth_api.dart';
import '../widgets/input_text.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

///////// HAY QUE  INSTANCIAR GLOBALKEY PARA PODER REALIZAR LAS VALIDACIONES //////
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();
  var _email = '',_password = '';
  var _isFetching = false;
  @override
//  -------  INICIALIZAR CAMBIAR EL COLOR ICONOS PARTE SUPERIOR CELULAR    ----//
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }
  /////////////////////////////////////////////////////////////////////////////////
  ////////////////////////[ METODO PARA HACER LA VALIDACION ]//////////////////////
  _submit() async {
    if (_isFetching) return;

    final isValid = _formKey.currentState.validate();

    if (isValid) {
      setState(() {
        _isFetching = true;
      });
      final isOk = await _authAPI.login(context, email: _email, password: _password);

      setState(() {
        _isFetching = false;
      });
      if (isOk) {
        print("Login Ok");
//          Navigator.pushNamed(context, "home");
        Navigator.pushNamedAndRemoveUntil(context, 'splash', (_) => false);
      }
    }
  }
  //////////////////////////////////////////////////////////////////////
//---------------------------PARTE GRAFICA -----------------------------------//
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: GestureDetector(
          onTap: (){ FocusScope.of(context).requestFocus(FocusNode());},
          child: SingleChildScrollView(
            child: Container(
              child: Stack(
                children: <Widget>[
                  ///////////  background///////////
            new Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.4, 0.9],
                  colors: [
                    Color(0xFFFF835F),
                    Color(0xFFFC663C),
                    Color(0xFFFF3F1A),
                  ],
                ),
              ),
            ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 80),
                          Card(
                            child: Container(
                              width: 90,
                              height: 90,
//                              margin: EdgeInsets.only(top: size.width*0.3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(color: Colors.black26, blurRadius: 25)
                                ],
                              ),
                              child: Image(
                                width: 130,
                                height: 130,
                                image: AssetImage("assets/images/avatar7.png"),
                              ),
                            ),

                          ),
                          SizedBox(height: 30),
                          Card(
                            elevation: 4.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              ////---------[ TEXTFIELDS Y BOTON DE INGRESO  ]------------------////

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 350,
                                        minWidth: 350,
                                      ),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[

                                            /////////////  Email//////////////
                                            new ListTile(
                                                leading: const Icon(Icons.email, color: Colors.black),
                                                title:
                                                InputText(
                                                  label: "Correo Electronico",
                                                  inputType: TextInputType.emailAddress,
                                                  validator:(String text){
                                                    if(text.contains("@")){
                                                      _email=text;
                                                      return null;
                                                    }
                                                    return "Correo Invalido";
                                                  },
                                          ),
                                        ),


                                            SizedBox(height: 30),
                                            /////////////// password////////////////////
                                            new ListTile(
                                                leading: const Icon(Icons.vpn_key, color: Colors.black),
                                                title: InputText(
                                                  label: "Contrasena", isSecure: true,validator:(String text){
                                                  if(text.isNotEmpty && text.length>2){
                                                    _password = text;
                                                    return null;
                                                  }
                                                  return "contrasena invalida";
                                                },),)

                                          ],
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 10),
                                  /////////////  LogIn Botton///////////////////
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: 350,
                                      minWidth: 350,
                                    ),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.symmetric(vertical: 17),
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(4),
                                      onPressed: ()=> _submit(),
                                      child: Text("Ingresar", style: TextStyle(fontSize: 20)),
                                    ),
                                  ),
//                              //--------------------------------------------------------------------//
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Eres Nuevo?", style: TextStyle(fontSize: 16, color: Colors.black54)),
                                      CupertinoButton(
                                        onPressed: () => Navigator.pushNamed(context, "signup"),
                                        child: Text("Registrate", style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        )
    );
  }
}

