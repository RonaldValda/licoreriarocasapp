import 'package:flutter/material.dart';
class ButtonChip extends StatefulWidget {
  ButtonChip({Key? key,required this.text,required this.fontSize,required this.size,
    required this.colorText,required this.colorButton,
    required this.onPressed
  }) : super(key: key);
  final String text;
  final double fontSize;
  final Size size;
  final Color colorButton;
  final Color colorText;
  final VoidCallback onPressed;
  @override
  _ButtonChipState createState() => _ButtonChipState();
}

class _ButtonChipState extends State<ButtonChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:widget.size.width,
      height: widget.size.height,
      decoration: BoxDecoration(
        color: widget.colorButton,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: widget.onPressed,
        child: Text(widget.text,
          style: TextStyle(
            color: widget.colorText,
            fontSize: widget.fontSize
          ),
        )
      ),
    );
  }
}