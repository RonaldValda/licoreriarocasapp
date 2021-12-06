import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
enum getOpcionCategoria{
  categoria,
  subcategoria,
  etiqueta
}
enum getOpcionOperacion{
  registrar,
  modificar,
  eliminar
}
Future<bool> dialogRegistroCategoria(
  BuildContext context,
  Categoria categoria,
  Subcategoria subcategoria,
  Etiqueta etiqueta,
  int opcionTipo,
  int opcionOperacion
)async{
  TextEditingController controller=TextEditingController();
  if(opcionTipo==getOpcionCategoria.categoria.index)
  controller.text=categoria.nombreCategoria;
  if(opcionTipo==getOpcionCategoria.subcategoria.index)
  controller.text=subcategoria.nombreSubcategoria;
  if(opcionTipo==getOpcionCategoria.etiqueta.index)
  controller.text=etiqueta.nombreEtiqueta;
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
                  if(opcionTipo==getOpcionCategoria.categoria.index)
                  Text(opcionOperacion==getOpcionOperacion.registrar.index?"Registrar categoría":"Modificar categoría",style: TextStyle(fontSize: 20)),
                  if(opcionTipo==getOpcionCategoria.subcategoria.index)
                  Text(opcionOperacion==getOpcionOperacion.registrar.index?"Registrar subcategoría":"Modificar subcategoría",style: TextStyle(fontSize: 20)),
                  if(opcionTipo==getOpcionCategoria.etiqueta.index)
                  Text(opcionOperacion==getOpcionOperacion.registrar.index?"Registrar etiqueta":"Modificar etiqueta",style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children:[
                    if(opcionTipo==getOpcionCategoria.categoria.index)
                    TextFFBasico(
                      controller: controller, 
                      labelText: "Nombre categoría", 
                      onChanged: (x){
                        categoria.nombreCategoria=x;
                      }
                    ),
                    if(opcionTipo==getOpcionCategoria.subcategoria.index)
                    TextFFBasico(
                      controller: controller, 
                      labelText: "Nombre subcategoría", 
                      onChanged: (x){
                        subcategoria.nombreSubcategoria=x;
                      }
                    ),
                    if(opcionTipo==getOpcionCategoria.etiqueta.index)
                    TextFFBasico(
                      controller: controller, 
                      labelText: "Nombre etiqueta", 
                      onChanged: (x){
                        etiqueta.nombreEtiqueta=x;
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
