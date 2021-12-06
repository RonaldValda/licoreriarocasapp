import 'package:flutter/material.dart';
class ButtonRegistro extends StatefulWidget {
  ButtonRegistro({Key? key,required this.texto,required this.onPressed,this.color=Colors.green}) : super(key: key);
  final String texto;
  final VoidCallback onPressed;
  final Color color;
  @override
  _ButtonRegistroState createState() => _ButtonRegistroState();
}

class _ButtonRegistroState extends State<ButtonRegistro> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: widget.color,
      ),
      child: MaterialButton(
        clipBehavior: Clip.antiAlias,
        child: Text(widget.texto,style: TextStyle(
          color: Colors.white70,fontSize: 20
        ),),
        onPressed: widget.onPressed
      ),
    );
  }
}