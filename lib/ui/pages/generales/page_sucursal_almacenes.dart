import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_sucursal_almacen.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/buttons.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/dialog_registro_sucursal_almacen.dart';
class PageSucursalAlmacenes extends StatefulWidget {
  PageSucursalAlmacenes({Key? key,required this.sucursal}) : super(key: key);
  final Sucursal sucursal;
  @override
  _PageSucursalAlmacenesState createState() => _PageSucursalAlmacenesState();
}

class _PageSucursalAlmacenesState extends State<PageSucursalAlmacenes> {
  UseCaseSucursalAlmacen ucSucursalAlmacen=UseCaseSucursalAlmacen();
  List<SucursalAlmacen> sucursalAlmacenes=[];
  @override
  void initState() {
    super.initState();
    ucSucursalAlmacen.obtenerSucursalAlmacenes(widget.sucursal.id)
    .then((resultado){
      if(resultado["completado"]){
        sucursalAlmacenes=resultado["sucursal_almacenes"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    sucursalAlmacenes.sort((a,b)=>a.localizacion.compareTo(b.localizacion));
    return Scaffold(
      appBar: AppBar(
        title: Text("Sucursal almacenes"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: sucursalAlmacenes.length,
                itemBuilder: (context, index) {
                  var almacen=sucursalAlmacenes[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Localización: ${almacen.localizacion}"),
                            if(almacen.seleccionado)
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ButtonChip(
                                    text: "Modificar", 
                                    fontSize: 13,
                                    size: Size(60,25), 
                                    colorText: Colors.white70, 
                                    colorButton: Colors.blue.shade900, 
                                    onPressed: ()async{
                                      try{
                                        SucursalAlmacen almacenAux=SucursalAlmacen.copyWith(almacen);
                                        bool respuesta=await dialogRegistroSucursalAlmacen(context, almacenAux,getOpcionOperacion.modificar.index);
                                        if(respuesta){
                                          ucSucursalAlmacen.modificarSucursalAlmacen(almacenAux)
                                          .then((completado){
                                            if(completado){
                                              sucursalAlmacenes.removeWhere((element) => element.id==almacenAux.id);
                                              sucursalAlmacenes.add(almacenAux);
                                              almacenAux.seleccionado=true;
                                              setState(() {
                                                
                                              });
                                            }
                                          });
                                        }
                                      }catch(exception){
                                        print(exception);
                                      }
                                    }
                                  ),
                                  SizedBox(width: 2,),
                                  ButtonChip(
                                    text: "Eliminar", 
                                    fontSize: 13,
                                    size: Size(60,25), 
                                    colorText: Colors.white70, 
                                    colorButton: Colors.red.shade900, 
                                    onPressed: ()async{
                                      ucSucursalAlmacen.eliminarSucursalAlmacen(almacen)
                                      .then((completado){
                                        if(completado){
                                          sucursalAlmacenes.removeWhere((element) => element.id==almacen.id);
                                          setState(() {
                                            
                                          });
                                        }
                                      });
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: (){
                          almacen.seleccionado=!almacen.seleccionado;
                          setState(() {
                            
                          });
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height:0.5,
                        color: Colors.grey,
                      )
                    ],
                  );
                },
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          try{
            SucursalAlmacen almacenAux=SucursalAlmacen.vacio();
            bool respuesta=await dialogRegistroSucursalAlmacen(context, almacenAux,getOpcionOperacion.registrar.index);
            if(respuesta){
              ucSucursalAlmacen.registrarSucursalAlmacen(widget.sucursal.id, almacenAux)
              .then((resultado){
                if(resultado["completado"]){
                  sucursalAlmacenes.add(almacenAux);
                  setState(() {
                    
                  });
                }
              });
            }
          }catch(exception){
            print(exception);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}