import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secret_chat/api/auth_api.dart';
import 'package:flutter_secret_chat/utils/dialogs.dart';
import 'package:flutter_secret_chat/utils/responsive.dart';

import '../widgets/Circle.dart';
import '../widgets/input_text.dart';
import 'package:flutter_secret_chat/utils/responsive.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
///////// HAY QUE INSTANCIAR GLOBALKEY PARA PODER REALIZAR LAS VALIDACIONES //////
  final _formKey = GlobalKey<FormState>();
  final _authAPI = AuthAPI();
  var _email = '',
      _password = '';
  var _isFetching = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

/////////////////////////////////////////////////////////////////////////////////
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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = Responsive(context);

    return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: <Widget>[

                Positioned(
                  right: -size.width * 0.25,
                  top: -size.width * 0.36,
                  child: Circle(
                    radius: size.width * 0.45,
                    colors: [
                      Colors.pink,
                      Colors.pinkAccent,
                    ],
                  ),
                ),
                Positioned(
                  left: -size.width * 0.15,
                  top: -size.width * 0.34,
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
//                      width: size.width,
//                      height: size.height,

                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                children: <Widget>[
                                  Container(
                                    width: responsive.wp(23),
                                    height: responsive.wp(23),
                                    margin: EdgeInsets.only( top: size.width * 0.3),
                                    decoration: BoxDecoration(

                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black26,
                                              blurRadius: 25)
                                        ]
                                    ),
                                  ),
                                  SizedBox(height: responsive.hp(4)),
                                  Text("Bienvenidos de nuevo.\n Welcome Back",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: responsive.ip(2),fontWeight: FontWeight.w300))
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
                                            label: "Correo Electronico",
                                            inputType: TextInputType.emailAddress,
                                            fontSize: responsive.ip(2),
                                            validator: (String text) {
                                              if (text.contains("@")) {
                                                _email = text;
                                                return null;
                                              }
                                              return "Correo Invalido";
                                            },),

                                          SizedBox(height: responsive.hp(3)),
                                          InputText(
                                            label: "Contrasena",
                                            isSecure: true,
                                            fontSize: responsive.ip(2),
                                            validator: (String text) {
                                              if (text.isNotEmpty && text.length > 5) {
                                                _password = text;
                                                return null;
                                              }
                                              return "contrasena invalida";
                                            },)


                                        ],
                                      ),
                                    )
                                ),
                                SizedBox(height: responsive.hp(4)),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 350,
                                    minWidth: 350,
                                  ),
                                  child: CupertinoButton(
                                    padding: EdgeInsets.symmetric( vertical: responsive.ip(2),),
                                    color: Colors.pinkAccent,
                                    borderRadius: BorderRadius.circular(4),
                                    onPressed: () => _submit(),
                                    child: Text("Ingresar",
                                        style: TextStyle(fontSize: responsive.ip(2.5))),
//                                          style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                                SizedBox(height: responsive.hp(2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Eres Nuevo?", style: TextStyle(
                                        fontSize: responsive.ip(1.8), color: Colors.black54)),
                                    CupertinoButton(
                                      onPressed: () =>
                                          Navigator.pushNamed(
                                              context, "signup"),
                                      child: Text("Registrate",
                                          style: TextStyle(fontSize: responsive.ip(1.8),
                                              color: Colors.pinkAccent)),
                                    )
                                  ],
                                ),
                                SizedBox(height: responsive.hp(5)),

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
              ],
            ),
          ),
        )
    );
  }
}


