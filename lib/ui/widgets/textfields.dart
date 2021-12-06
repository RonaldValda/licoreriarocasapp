import 'package:flutter/material.dart';

class TextFFBasico extends StatefulWidget {
  TextFFBasico({Key? key,required this.controller,required this.labelText,
    required this.onChanged, this.isPassword=false,this.isEnabled=true,this.textAlign=TextAlign.left
  }) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final Function onChanged;
  final bool isPassword;
  final bool isEnabled;
  final TextAlign textAlign;
  @override
  _TextFFBasicoState createState() => _TextFFBasicoState();
}

class _TextFFBasicoState extends State<TextFFBasico> {
  final color=Colors.black;
  final colorFill=Colors.white12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      controller: widget.controller,
      style: TextStyle(color: color.withOpacity(0.8),
        fontSize: 15
      ),
      obscureText: widget.isPassword,
      enabled: widget.isEnabled,
      enableSuggestions: false,
      maxLines: 1,
      
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        //counterText: controllerCII!.text.length.toString(),
        //hintText: "Capacidad de inversión inicial",
        hintStyle: TextStyle(color: color.withOpacity(0.8),fontSize: 15),
        filled: true,
        fillColor: colorFill,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 18
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.5))
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7))
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.5))
        ),
      ),
      onChanged:(x){ 
        widget.onChanged(x);
      },
    );
  }
}

class TextFFOnTap extends StatefulWidget {
  TextFFOnTap({Key? key,required this.controller,required this.label,required this.onTap}) : super(key: key);
  final TextEditingController controller;
  final String label;
  final VoidCallback onTap;
  @override
  _TextFFOnTapState createState() => _TextFFOnTapState();
}

class _TextFFOnTapState extends State<TextFFOnTap> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.8),fontSize: 15),
          filled: true,
          fillColor: Colors.transparent,
          labelText: widget.label,
          labelStyle: TextStyle(
            fontSize: 14
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.black.withOpacity(0.7))
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.blue.withOpacity(0.7))
          ),
          
        ),
        onTap:widget.onTap
      );
  }
}
class TextFFLimpio extends StatefulWidget {
  TextFFLimpio({Key? key,required this.controller,
    required this.onChanged, this.isPassword=false,this.isEnabled=true,this.textAlign=TextAlign.left
  }) : super(key: key);
  final TextEditingController controller;
  final Function onChanged;
  final bool isPassword;
  final bool isEnabled;
  final TextAlign textAlign;
  @override
  _TextFFLimpioState createState() => _TextFFLimpioState();
}

class _TextFFLimpioState extends State<TextFFLimpio> {
  final color=Colors.black;
  final colorFill=Colors.white12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: widget.textAlign,
      controller: widget.controller,
      style: TextStyle(color: color.withOpacity(0.8),
        fontSize: 15
      ),
      obscureText: widget.isPassword,
      enabled: widget.isEnabled,
      //enableSuggestions: false,
      maxLines: 1,
      
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        //counterText: controllerCII!.text.length.toString(),
        //hintText: "Capacidad de inversión inicial",
        hintStyle: TextStyle(color: color.withOpacity(0.8),fontSize: 15),
        filled: true,
        fillColor: colorFill,
        labelStyle: TextStyle(
          fontSize: 18
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.transparent)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.transparent)
        ),
      ),
      onChanged:(x){ 
        widget.onChanged(x);
      },
    );
  }
}