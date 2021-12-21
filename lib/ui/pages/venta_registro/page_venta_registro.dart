
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/domain/usecases/venta/usecase_cliente.dart';
import 'package:licoreriarocasapp/ui/pages/cliente/widgets/dialog_registro_cliente.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/dialog_registro_categoria.dart';
import 'package:licoreriarocasapp/ui/pages/venta_registro/widgets/button_flotante_venta_registro.dart';
import 'package:licoreriarocasapp/ui/pages/venta_registro/widgets/dialog_buscar_cliente.dart';
import 'package:licoreriarocasapp/ui/pages/venta_registro/widgets/horizontal_data_table_venta_productos.dart';
import 'package:licoreriarocasapp/ui/provider/venta/ventaProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class PageVentaRegistro extends StatefulWidget {
  PageVentaRegistro({Key? key}) : super(key: key);

  @override
  _PageVentaRegistroState createState() => _PageVentaRegistroState();
}

class _PageVentaRegistroState extends State<PageVentaRegistro> {
  TextEditingController? controllerComprobante;
  TextEditingController? controllerCliente;
  Cliente cliente=Cliente.vacio();
  UseCaseCliente useCaseCliente=UseCaseCliente();
  @override
  void initState() {
    super.initState();
    controllerComprobante=TextEditingController(text: "");
    controllerCliente=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final ventaProvider=Provider.of<VentaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva venta"),
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(left: 5,right:5,top: 10,bottom: 5),
                    children: [
                      TextFFBasico(
                        controller: controllerComprobante!, 
                        labelText: "Comprobante", 
                        onChanged: (x){

                        }
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if(cliente.id!="")
                      Text("Cliente"),
                      Container(
                        height: 50,
                        width:MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black45,
                            style: BorderStyle.solid
                          )
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(cliente.id==""?"":"${cliente.ciNit} | ${cliente.nombres}"),
                              ),
                            ),
                            Container(
                              width: 80,
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    child: MaterialButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: ()async{
                                        try{
                                          cliente=Cliente.vacio();
                                          await dialogBuscarCliente(context, cliente);
                                          ventaProvider.ventaCarrito.cliente=cliente;
                                          
                                        }catch(ex){
                                          print(ex);
                                        }
                                      },
                                      child: Icon(Icons.search),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    child: MaterialButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: ()async{
                                        try{
                                          cliente=Cliente.vacio();
                                          bool respuesta=await dialogRegistroCliente(context, cliente, getOpcionOperacion.registrar.index);
                                          if(respuesta){
                                             useCaseCliente.registrarCliente(cliente)
                                             .then((resultado){
                                               if(!resultado["completado"]){
                                                 cliente=Cliente.vacio();
                                               }else{
                                                 cliente=resultado["cliente"];
                                               }
                                               setState(() {
                                                 
                                              });
                                             });
                                          }else{
                                            setState(() {
                                              cliente=Cliente.vacio();
                                            });
                                          }
                                        }catch(e){

                                        }
                                      },
                                      child: Icon(Icons.person_add),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(height: 5,),
                     // if(compraProvider.compra.id!="")
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height-210,
                        decoration: BoxDecoration(
                          border: Border(
                            top:BorderSide(
                              color: Colors.black38,
                              width: 0.5
                            )
                          )
                        ),
                        child: HorizontalDataTableVentaProductos())
                    ],
                  )
                )
              ],
            ),
          ),
          ButtonFlotanteVentaRegitro()
        ],
      )
    );
  }
}