
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_sucursal.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_sucursal_almacenes.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_sucursal_registro.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/buttons.dart';
class PageSucursalesEmpresa extends StatefulWidget {
  PageSucursalesEmpresa({Key? key}) : super(key: key);

  @override
  _PageSucursalesEmpresaState createState() => _PageSucursalesEmpresaState();
}

class _PageSucursalesEmpresaState extends State<PageSucursalesEmpresa> {
  List<Sucursal> sucursales=[];
  UseCaseSucursal useCaseSucursal=UseCaseSucursal();
  TextEditingController? controllerDescripcion;
  TextEditingController? controllerDireccion;
  TextEditingController? controllerTelefono1;
  TextEditingController? controllerTelefono2;
  TextEditingController? controllerTelefono3;
  Sucursal sucursalSeleccionado=Sucursal.vacio();
  @override
  void initState() {
    super.initState();
    controllerDescripcion=TextEditingController(text: "");
    controllerDireccion=TextEditingController(text: "");
    controllerTelefono1=TextEditingController(text: "");
    controllerTelefono2=TextEditingController(text: "");
    controllerTelefono3=TextEditingController(text: "");
    useCaseSucursal.obtenerSucursales()
    .then((resultado){
      if(resultado["completado"]){
        sucursales=resultado["sucursales"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    sucursales.sort((a,b)=>a.descripcion.compareTo(b.descripcion));
    return Scaffold(
      appBar: AppBar(
        title: Text("Sucursales empresa"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: sucursales.length,
                itemBuilder: (context, index) {
                  Sucursal sucursal=sucursales[index];
                  return Column(
                    children: [
                      ListTile(
                        title:  Column(
                          children: [
                            Row(
                              children: [
                                Text("Descripción: "),
                                Text("${sucursal.descripcion}")
                              ],
                            ),
                            Row(
                              children: [
                                Text("Dirección: ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic
                                  ),
                                ),
                                Text("${sucursal.direccion}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text("Teléfono principal: ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic
                                  ),
                                ),
                                Text("${sucursal.telefonos[0]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic
                                  ),
                                )
                              ],
                            ),
                            if(sucursal.seleccionado) 
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height:40,
                              child: Row(
                                children: [
                                  ButtonChip(
                                    text: "Almacenes", 
                                    fontSize: 13, 
                                    size: Size(80, 25), 
                                    colorText: Colors.white70, 
                                    colorButton: Colors.indigo, 
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context){
                                            return PageSucursalAlmacenes(sucursal: sucursal);
                                          }
                                        )
                                      );
                                    }
                                  ),
                                  SizedBox(width: 2,),
                                  ButtonChip(
                                    text: "Modificar", 
                                    fontSize: 13, 
                                    size: Size(80, 25), 
                                    colorText: Colors.white70, 
                                    colorButton: Colors.indigo, 
                                    onPressed: ()async{
                                      sucursalSeleccionado=Sucursal.copyWith(sucursal);
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context){
                                            return PageSucursalRegistro(sucursal: sucursalSeleccionado);
                                          }
                                        )
                                      );
                                      if(sucursalSeleccionado.id!=""){
                                        setState(() {
                                          sucursales.removeWhere((element) => element.id==sucursal.id);
                                          sucursales.add(sucursalSeleccionado);
                                        });
                                      }
                                    }
                                  ),
                                  SizedBox(width: 2,),
                                  ButtonChip(
                                    text: "Eliminar", 
                                    fontSize: 13, 
                                    size: Size(80, 25), 
                                    colorText: Colors.white70, 
                                    colorButton: Colors.redAccent, 
                                    onPressed: (){
                                      useCaseSucursal.eliminarSucursal(sucursal)
                                      .then((completado) {
                                        if(completado){
                                          sucursales.removeWhere((element) => element.id==sucursal.id);
                                          setState(() {
                                            
                                          });
                                        }
                                      });
                                    }
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        onTap: (){
                          setState(() {
                            sucursal.seleccionado=!sucursal.seleccionado;
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          sucursalSeleccionado=Sucursal.vacio();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return PageSucursalRegistro(sucursal: sucursalSeleccionado);
              }
            )
          );
          if(sucursalSeleccionado.id!=""){
            setState(() {
              sucursales.add(sucursalSeleccionado);
            });
          }
        },
        isExtended: true,
        child: Icon(Icons.add),
      ),
    );
  }
}