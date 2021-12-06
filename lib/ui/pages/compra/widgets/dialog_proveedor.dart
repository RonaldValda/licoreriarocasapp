import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_proveedor.dart';
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
enum getBuscarProveedor{
  buscar_ci,
  buscar_nombres
}
Future dialogBuscarProveedor(
  BuildContext context,
  Proveedor proveedor
)async{
  TextEditingController controller=TextEditingController(text: "");
  int tipoBusqueda=0;
  List<Proveedor> proveedores=[];
  UseCaseProveedor useCaseProveedor=UseCaseProveedor();
  bool buscado=false;
  Widget widgetListadoProveedores(List<Proveedor> proveedores){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: ListView.builder(
        itemCount: proveedores.length,
        itemBuilder: (context, index) {
          var p=proveedores[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color:Colors.grey
                )
              )
            ),
            child:ListTile(
              title: Text(p.nombres),
              trailing: Icon(Icons.check),
              onTap: (){
                proveedor.id=p.id;
                proveedor.ciNit=p.ciNit;
                proveedor.nombres=p.nombres;
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
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
                  Text("Buscar proveedor",style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Radio(
                            value: getBuscarProveedor.buscar_ci.index, 
                            groupValue: tipoBusqueda, 
                            onChanged: (value){
                              tipoBusqueda=getBuscarProveedor.buscar_ci.index;
                              setState(() {
                                
                              });
                            }
                          ),
                          Text("CI/NIT")
                        ],
                      ),
                      SizedBox(width:5),
                      Column(
                        children: [
                          Radio(
                            value: getBuscarProveedor.buscar_nombres.index,
                            groupValue: tipoBusqueda, 
                            onChanged: (value){
                              tipoBusqueda=getBuscarProveedor.buscar_nombres.index;
                              setState(() {
                                
                              });
                            }
                          ),
                          Text("Nombres")
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children:[
                        TextFFBasico(
                          controller: controller, 
                          labelText: "Dato", 
                          onChanged: (x){
                            proveedor.ciNit=x;
                          }
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              if(proveedores.length>0)
              widgetListadoProveedores(proveedores),
              if(proveedores.length==0&&buscado==true)
              Text("No se encontró ningún proveedor",style: TextStyle(color: Colors.red),),
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
                  child: Text("Buscar",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white70
                    ),
                  ),
                  onPressed: (){
                    String ciNit="";
                    String nombres="";
                    if(tipoBusqueda==getBuscarProveedor.buscar_ci.index){
                      ciNit=controller.text;
                    }else{
                      nombres=controller.text;
                    }
                    buscado=true;
                    useCaseProveedor.buscarProveedor(ciNit,nombres)
                    .then((resultado){
                      if(resultado["completado"]){
                        proveedores=resultado["proveedores"];
                        if(proveedores.length==0){
                          setState(() {
                                
                          });
                        }else if(proveedores.length==1){
                          proveedor.id=proveedores[0].id;
                          proveedor.ciNit=proveedores[0].ciNit;
                          proveedor.nombres=proveedores[0].nombres;
                          Navigator.pop(context);
                        }else{
                          setState(() {
                                
                          });
                        }
                      }
                    });
                    //Navigator.pop(context,true);
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
