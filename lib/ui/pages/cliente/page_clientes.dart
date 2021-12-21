import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/domain/usecases/venta/usecase_cliente.dart';
import 'package:licoreriarocasapp/ui/pages/cliente/widgets/dialog_registro_cliente.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/dialog_registro_categoria.dart';
class PageClientes extends StatefulWidget {
  PageClientes({Key? key}) : super(key: key);

  @override
  _PageClientesState createState() => _PageClientesState();
}

class _PageClientesState extends State<PageClientes> {
  List<Cliente> clientes=[];
  Cliente clienteSel=Cliente.vacio();
  UseCaseCliente useCaseCliente=UseCaseCliente();
  @override
  void initState() {
    super.initState();
    useCaseCliente.obtenerClientes()
    .then((resultado){
      if(resultado["completado"]){
        clientes=resultado["clientes"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    clientes.sort((a,b)=>a.nombres.compareTo(b.nombres));
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: clientes.length,
          itemBuilder: (context, index) {
            var cliente=clientes[index];
            return ListTile(
              title: Text("${cliente.nombres}"),
              subtitle: Text("${cliente.telefono}"),
              trailing: Container(
                width: 80,
                height: 40,
                child: Row(
                  children:[
                    Container(
                      width: 35,
                      height: 40,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.edit,color:Colors.blue),
                        onPressed:()async{
                          try{
                            clienteSel=Cliente.copyWith(cliente);
                            bool respuesta=await dialogRegistroCliente(context, clienteSel, getOpcionOperacion.modificar.index);
                            if(respuesta){
                              useCaseCliente.modificarCliente(clienteSel)
                              .then((resultado){
                                if(resultado["completado"]){
                                  clientes.removeWhere((element) => element.id==clienteSel.id);
                                  clientes.add(clienteSel);
                                  clienteSel=Cliente.vacio();
                                  setState(() {
                                    
                                  });
                                }
                              });
                            }
                          }catch(e){

                          }
                        }
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 40,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.delete,color: Colors.redAccent,),
                        onPressed: (){
                          useCaseCliente.eliminarCliente(cliente.id)
                          .then((resultado){
                            if(resultado["completado"]){
                              clientes.removeWhere((element) => element.id==cliente.id);
                              setState(() {
                                
                              });
                            }
                          });
                        }
                      ),
                    )
                  ]
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          try{
            clienteSel=Cliente.vacio();
            bool respuesta=await dialogRegistroCliente(context,clienteSel,getOpcionOperacion.registrar.index);
            if(respuesta){
              useCaseCliente.registrarCliente(clienteSel)
              .then((resultado){
                if(resultado["completado"]){
                  clientes.add(clienteSel);
                  clienteSel=Cliente.vacio();
                  setState(() {
                    
                  });
                }
              });
            }
          }catch(e){

          }
          
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}