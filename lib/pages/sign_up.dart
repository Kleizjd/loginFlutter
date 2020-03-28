import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/api/auth_api.dart';
import 'package:flutter_secret_chat/utils/dialogs.dart';
import 'package:flutter_secret_chat/utils/responsive.dart';

import '../widgets/circle.dart';
import '../widgets/input_text.dart';



class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();

  var _username='', _email='', _password='';
  var _isFetching = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _submit() async {
    if (_isFetching) return;

    final isValid= _formKey.currentState.validate();

    if(isValid){
        setState(() {_isFetching = true;});
      final isOk = await _authAPI.register(context,
          username: _username, email: _email, password: _password);

        setState(() {_isFetching = false;});
      if(isOk){
        print("Registrado");
//        Navigator.pushNamed(context, "home");
        Navigator.pushNamedAndRemoveUntil(context, 'splash', (_) => false);

      }
    }
  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final responsive = Responsive(context);

    return Scaffold(
        body: GestureDetector(
          onTap: (){ FocusScope.of(context).requestFocus(FocusNode());},
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: <Widget>[

                Positioned(
                  right: -size.width * 0.25,
                  top: -size.width*0.36,
                  child: Circle(
                    radius: size.width * 0.45,
                    colors: [
                      Colors.pink,
                      Colors.pinkAccent,
                    ],
                  ),
                ),
//
                Positioned(
                  left: -size.width * 0.15,
                  top: -size.width*0.34,
                  child: Circle(
                    radius: size.width * 0.35,
                    colors: [
                      Colors.orange,
                      Colors.deepOrange
                    ],
                  ),
                ),
                SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      height: size.height,

                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                children: <Widget>[
                                  Container(
                                    width: responsive.wp(25),
                                    height: responsive.wp(25),
                                    margin: EdgeInsets.only(top: size.width*0.3),
                                    decoration: BoxDecoration(

                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(90),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black26, blurRadius: 25)
                                        ]
                                    ),
                                  ),
                                  SizedBox(height: responsive.hp(1.2)),
                                  Text("Hola!.\n Registrate para Ingresar",textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: responsive.ip(1.9), fontWeight: FontWeight.w300)),
                                ]

                            ),
                            Column(
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
                                          InputText(
                                            label: "Nombre completo",
                                            fontSize: responsive.ip(1.6),
                                            validator:(String text){
                                              if(RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(text)){///agregue el espacio en el nombre \s
                                                _username=text;
                                                return null;
                                              }
                                              return "Usuario Invalido";
                                            },),
                                          SizedBox(height: responsive.hp(1.2),),
                                          InputText(
                                            label: "Correo Electronico",
                                            fontSize: responsive.ip(1.6),
                                            inputType: TextInputType.emailAddress,
                                            validator:(String text){
                                              if(text.contains("@")){
                                                print(text);
                                                _email=text;
                                                return null;
                                              }
                                              return "Correo Invalido";
                                            },
                                          ),
                                          SizedBox(height: 12),
                                          InputText(
                                            label: "Contrasena",
//                                            isSecure: true,
                                            fontSize: responsive.ip(1.6),
                                            validator:(String text){
                                            if(text.isNotEmpty && text.length>5){
                                              _password=text;
                                              return null;
                                            }
                                            return "contrasena invalida";
                                          },)


                                        ],
                                      ),
                                    )
                                ),
                                SizedBox(height: 20),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 350,
                                    minWidth: 350,
                                  ),
                                  child: CupertinoButton(
                                    padding: EdgeInsets.symmetric(vertical: 17),
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(4),
                                    onPressed: ()=> _submit(),
                                    child: Text("Registrate", style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Ya tienes Cuenta?", style: TextStyle(fontSize: 16, color: Colors.black54)),
                                    CupertinoButton(
                                      onPressed: ()=>Navigator.pop(context),
                                      child: Text("Ingresar", style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
                                    )
                                  ],
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    )
                ),
                // START FETCHING DIALOG LOADING
                _isFetching ? Dialogs.loading() : Container(),
                // END FETCHING DIALOG
//                Positioned(
//                  left: 10,
//                  top: 15,
//                  child: SafeArea(
//                    child: CupertinoButton(
//                      padding: EdgeInsets.all(10),
//                      borderRadius: BorderRadius.circular(30),
//                      color: Colors.black12,
//                      onPressed:()=>Navigator.pop(context),
//                      child: Icon(Icons.arrow_back, color: Colors.white,),),
//                  ),
//                ),

              ],
            ),
          ),
        )
    );
  }
}

