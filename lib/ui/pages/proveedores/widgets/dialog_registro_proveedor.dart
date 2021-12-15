import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';

enum getOpcionOperacion{
  registrar,
  modificar,
  eliminar
}
Future<bool> dialogRegistroProveedor(
  BuildContext context,
  Proveedor proveedor,
  int opcionOperacion
)async{
  TextEditingController controllerCI=TextEditingController();
  TextEditingController controllerNombres=TextEditingController();
  controllerCI.text=proveedor.ciNit;
  controllerNombres.text=proveedor.nombres;
 return await showDialog(
    barrierLabel: "",
    barrierDismissible: true,
    context: context,
    useRootNavigator: true,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: 
              Column(
                children: [
                  Text(opcionOperacion==getOpcionOperacion.registrar.index?"Nuevo provedor":"Datos proveedor",style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children:[
                    TextFFBasico(
                      controller: controllerCI, 
                      labelText: "CI/NIT:", 
                      onChanged: (x){
                        proveedor.ciNit=x;
                      }
                    ),
                    SizedBox(height: 5,),
                    TextFFBasico(
                      controller: controllerNombres, 
                      labelText: "Nombres:", 
                      onChanged: (x){
                        proveedor.nombres=x;
                      }
                    ),
                  ]
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                  )
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    )
                  ),
                  child: Text(opcionOperacion==getOpcionOperacion.registrar.index?"Registrar":"Modificar",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70
                    ),
                  ),
                  onPressed: (){
                    Navigator.pop(context,true);
                  },
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}