import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';
import 'package:provider/provider.dart';
class DropdownTipoUsuario extends StatefulWidget {
  DropdownTipoUsuario({Key? key,required this.usuario}) : super(key: key);
  final Usuario usuario;
  @override
  _DropdownTipoUsuarioState createState() => _DropdownTipoUsuarioState();
}

class _DropdownTipoUsuarioState extends State<DropdownTipoUsuario> {
  List<String> items=["Vendedor","Administrador","Marketing"];
  bool dropdownActivado=false;
  final color=Colors.grey;
  final colorFill=Colors.white12;
  @override
  Widget build(BuildContext context) {
    if(widget.usuario.tipoUsuario==""){
      widget.usuario.tipoUsuario=items[0];
    }
    return  Container(
      padding: EdgeInsets.zero,
      height:70,
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Tipo usuario",
                style: TextStyle(
                  color:Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: 14
                ),
              )
            )
          ),
          Expanded(
            child: Container(
              height: 35,
              padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
              margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
              decoration: BoxDecoration(
                border: Border.all(color: color.withOpacity(0.7),width: 1),
                borderRadius: BorderRadius.circular(5),
                color: colorFill
              ),
              child: Row(
                children: [
                  DropdownButton(
                    icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                    style: dropdownActivado?TextStyle(
                      color:  Colors.black
                    ):TextStyle(
                      color: Colors.black
                    ),
                    
                    onTap: (){
                      setState(() {
                        dropdownActivado=true;
                      });
                      
                    },
                    dropdownColor: Colors.white.withOpacity(0.8),
                    value: widget.usuario.tipoUsuario,
                    onChanged: (String? value){
                      widget.usuario.tipoUsuario=value!;
                      setState(() {
                        dropdownActivado=false;
                      });
                    },
                    items: items
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(value),
                        )
                        
                      );
                    }).toList()
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
