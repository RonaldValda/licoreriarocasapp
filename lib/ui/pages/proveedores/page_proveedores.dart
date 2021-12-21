
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_proveedor.dart';
import 'package:licoreriarocasapp/ui/pages/proveedores/widgets/dialog_registro_proveedor.dart';
class PageProveedores extends StatefulWidget {
  PageProveedores({Key? key}) : super(key: key);

  @override
  _PageProveedoresState createState() => _PageProveedoresState();
}

class _PageProveedoresState extends State<PageProveedores> {
  List<Proveedor> proveedores=[];
  UseCaseProveedor useCaseProveedor=UseCaseProveedor();
  Proveedor proveedorSel=Proveedor.vacio();
  @override
  void initState() {
    super.initState();
    useCaseProveedor.obtenerProveedores()
    .then((resultado) {
      if(resultado["completado"]){
        proveedores=resultado["proveedores"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    proveedores.sort((a,b)=>a.nombres.compareTo(b.nombres));
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text("Proveedores"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                itemCount: proveedores.length,
                itemBuilder: (context, index) {
                  var proveedor=proveedores[index];
                  return Card(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("CI/NIT: ${proveedor.ciNit}"),
                              Text("Nombres: ${proveedor.nombres}"),
                              Text("Fecha registro: ${proveedor.fechaRegistro}"),
                              Text("Estado:  ${proveedor.estado?"Activo":"Inactivo"}")  
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: ()async{
                                  try{
                                    proveedorSel=Proveedor.copyWith(proveedor);
                                    bool respuesta=await dialogRegistroProveedor(context, proveedorSel, getOpcionOperacion.modificar.index);
                                    if(respuesta){
                                      proveedorSel.estado=true;
                                      useCaseProveedor.modificarProveedor(proveedorSel)
                                      .then((completado){
                                        if(completado){
                                          proveedores.removeWhere((element) => element.id==proveedorSel.id);
                                          proveedores.add(Proveedor.copyWith(proveedorSel));
                                          setState(() {
                                            
                                          });
                                        }
                                      });
                                    }
                                  }catch(e){

                                  }
                                }, 
                                icon: Icon(Icons.edit,color: Colors.blue,)
                              ),
                              IconButton(
                                onPressed: (){
                                  useCaseProveedor.eliminarProveedor(proveedor)
                                  .then((resultado){
                                    if(resultado){
                                      proveedores.removeWhere((element) => element.id==proveedor.id);
                                      setState(() {
                                        
                                      });
                                    }
                                  });
                                }, 
                                icon: Icon(Icons.delete,color:Colors.red)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          try{
            proveedorSel=Proveedor.vacio();
            bool respuesta=await dialogRegistroProveedor(context, proveedorSel, getOpcionOperacion.registrar.index);
            if(respuesta){
              proveedorSel.estado=true;
              useCaseProveedor.registrarProveedor(proveedorSel)
              .then((resultado){
                if(resultado["completado"]){
                  proveedores.add(Proveedor.copyWith(proveedorSel));
                  setState(() {
                    
                  });
                }
              });
            }
          }catch(e){

          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}