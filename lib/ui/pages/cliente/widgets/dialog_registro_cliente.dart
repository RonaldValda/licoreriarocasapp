import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/dialog_registro_categoria.dart';
import 'package:licoreriarocasapp/ui/utils/generales_utils.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
Future<bool> dialogRegistroCliente(
  BuildContext context,
  Cliente cliente,
  int operacion
)async{
  TextEditingController controllerCiNit=TextEditingController(text: cliente.ciNit);
  TextEditingController controllerNombres=TextEditingController(text: cliente.nombres);
  TextEditingController controllerFechaNacimiento=TextEditingController(text: cliente.fechaNacimiento);
  TextEditingController controllerEmail=TextEditingController(text: cliente.email);
  TextEditingController controllerTelefono=TextEditingController(text: cliente.telefono);
  DateTime pickedDate=DateTime(DateTime.now().year-18);
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
            insetPadding: EdgeInsets.all(5),
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: 
              Column(
                children: [
                  if(getOpcionOperacion.registrar.index==operacion)
                  Text("Agregar cliente",style: TextStyle(fontSize: 20)),
                  if(getOpcionOperacion.modificar.index==operacion)
                  Text("Datos cliente",style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 0),
                child: Column(
                  children: [
                    TextFFBasico(
                      controller: controllerCiNit, 
                      labelText: "Ci/Nit", 
                      onChanged: (x){
                        cliente.ciNit=x;
                      }
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFFBasico(
                      controller: controllerNombres, 
                      labelText: "Nombres", 
                      onChanged: (x){
                        cliente.nombres=x;
                      }
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFFOnTap(
                      controller: controllerFechaNacimiento, 
                      label: "Fecha de nacimiento", 
                      onTap: ()async{
                        DateTime firstDate= DateTime(DateTime.now().year-100);
                        DateTime lastDate= DateTime(DateTime.now().year-15);
                        await pickDate(context,pickedDate,firstDate,lastDate);
                        setState(() {
                          
                          controllerFechaNacimiento.text="${pickedDate.day.toString().padLeft(2,'0')}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.year.toString()}";
                          cliente.fechaNacimiento=controllerFechaNacimiento.text;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFFBasico(
                      controller: controllerEmail, 
                      labelText: "Email", 
                      onChanged: (x){
                        cliente.email=x;
                      }
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFFBasico(
                      controller: controllerTelefono, 
                      labelText: "Teléfono", 
                      onChanged: (x){
                        cliente.telefono=x;
                      }
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
              Container(
                padding:EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.orange.shade900,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                  )
                ),
                child: MaterialButton(
                  child: Text(operacion==getOpcionOperacion.registrar.index?"Registrar":"Modificar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70
                    ),
                  ),
                  onPressed: (){
                    Navigator.pop(context,true);
                  }
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}