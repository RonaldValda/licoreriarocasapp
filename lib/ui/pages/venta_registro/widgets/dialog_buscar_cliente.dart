import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/domain/usecases/venta/usecase_cliente.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
enum getBuscarCliente{
  buscar_ci,
  buscar_nombres
}
Future dialogBuscarCliente(
  BuildContext context,
  Cliente cliente
)async{
  TextEditingController controller=TextEditingController(text: "");
  int tipoBusqueda=0;
  List<Cliente> clientes=[];
  UseCaseCliente useCaseCliente=UseCaseCliente();
  bool buscado=false;
  Widget widgetListadoClientes(List<Cliente> clientes){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      child: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          var c=clientes[index];
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
              title: Text(c.nombres),
              trailing: Icon(Icons.check),
              onTap: (){
                cliente.id=c.id;
                cliente.ciNit=c.ciNit;
                cliente.nombres=c.nombres;
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
                  Text("Buscar cliente",style: TextStyle(fontSize: 20)),
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
                            value: getBuscarCliente.buscar_ci.index, 
                            groupValue: tipoBusqueda, 
                            onChanged: (value){
                              tipoBusqueda=getBuscarCliente.buscar_ci.index;
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
                            value: getBuscarCliente.buscar_nombres.index,
                            groupValue: tipoBusqueda, 
                            onChanged: (value){
                              tipoBusqueda=getBuscarCliente.buscar_nombres.index;
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
                            cliente.ciNit=x;
                          }
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              if(clientes.length>0)
              widgetListadoClientes(clientes),
              if(clientes.length==0&&buscado==true)
              Text("No se encontró ningún cliente",style: TextStyle(color: Colors.red),),
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
                    if(tipoBusqueda==getBuscarCliente.buscar_ci.index){
                      ciNit=controller.text;
                    }else{
                      nombres=controller.text;
                    }
                    buscado=true;
                    useCaseCliente.buscarCliente(ciNit,nombres)
                    .then((resultado){
                      if(resultado["completado"]){
                        clientes=resultado["clientes"];
                        if(clientes.length==0){
                          setState(() {
                                
                          });
                        }else if(clientes.length==1){
                          cliente.id=clientes[0].id;
                          cliente.ciNit=clientes[0].ciNit;
                          cliente.nombres=clientes[0].nombres;
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
