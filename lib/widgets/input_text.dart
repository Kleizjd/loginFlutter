import 'package:flutter/material.dart';

class InputText extends StatefulWidget {

  final String label;
  final Function(String) validator;
  final bool isSecure;
  final TextInputType inputType;
  final double fontSize;
  final Icon iconTexfield;
  final IconData iconWatchPass;
  const InputText({Key key,@required this.label, this.validator,
    this.isSecure = false,
    this.inputType = TextInputType.text, this.fontSize =17, this.iconTexfield, this.iconWatchPass}) : super(key: key);@override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  bool _isObscured;

  @override
  void initState() {
    _isObscured = widget.isSecure;
    super.initState();
  }

  Color _eyeButtonColor = Colors.grey;
  //////////////////////////
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      keyboardType: widget.inputType,
//      obscureText: widget.isSecure,
      obscureText: _isObscured,
      validator: widget.validator ,
      decoration: InputDecoration(
          prefixIcon: widget.iconTexfield,
          labelText: widget.label,
          alignLabelWithHint: true,
          labelStyle: TextStyle(fontSize: widget.fontSize),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          suffixIcon: IconButton(
            icon: Icon(widget.iconWatchPass, color: _eyeButtonColor),
            onPressed: (){
              if (_isObscured) {
                print('isObscure true');
                setState(() {
                  _isObscured = false;
                  _eyeButtonColor = Theme.of(context).primaryColor;
                });
              } else {
                print('isObscure false');

                setState(() {
                  _isObscured = true;
                  _eyeButtonColor = Colors.grey;
                });
              }

            },
          ),
      ),
    );
  }
}
