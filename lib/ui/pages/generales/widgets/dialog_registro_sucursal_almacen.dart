import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
enum getOpcionOperacion{
  registrar,
  modificar,
  eliminar
}
Future<bool> dialogRegistroSucursalAlmacen(
  BuildContext context,
  SucursalAlmacen almacen,
  int opcionOperacion
)async{
  TextEditingController controller=TextEditingController();
  controller.text=almacen.localizacion;
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
                  Text(opcionOperacion==getOpcionOperacion.registrar.index?"Registrar almacen":"Modificar almacen",style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children:[
                    TextFFBasico(
                      controller: controller, 
                      labelText: "Localización:", 
                      onChanged: (x){
                        almacen.localizacion=x;
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
                  child: Text(opcionOperacion==getOpcionOperacion.registrar.index?"Agregar":"Modificar",
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
