
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_compra.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_proveedor.dart';
import 'package:licoreriarocasapp/ui/pages/compra_registro/widgets/button_flotante_compra_registro.dart';
import 'package:licoreriarocasapp/ui/pages/compra_registro/widgets/dialog_proveedor.dart';
import 'package:licoreriarocasapp/ui/pages/compra_registro/widgets/horizontal_data_table_compra_productos.dart';
import 'package:licoreriarocasapp/ui/pages/proveedores/widgets/dialog_registro_proveedor.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/utils/generales_utils.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class PageCompraRegistro extends StatefulWidget {
  PageCompraRegistro({Key? key}) : super(key: key);

  @override
  _PageCompraRegistroState createState() => _PageCompraRegistroState();
}

class _PageCompraRegistroState extends State<PageCompraRegistro> {
  TextEditingController? controllerComprobante;
  TextEditingController? controllerProveedor;
  TextEditingController? controllerObservacionesPreCompra;
  TextEditingController? controllerFechaMovimiento;
  Proveedor proveedor=Proveedor.vacio();
  UseCaseProveedor useCaseProveedor=UseCaseProveedor();
  UseCaseCompra useCaseCompra=UseCaseCompra();
  bool preCompraIniciada=false;
  bool registroAtrazado=false;
  DateTime? pickedDate;  
  TimeOfDay? time;
  @override
  void initState() {
    super.initState();
    pickedDate=DateTime.now();
    time=TimeOfDay(hour: DateTime.now().hour,minute: DateTime.now().minute);
    controllerComprobante=TextEditingController(text: "");
    controllerProveedor=TextEditingController(text: "");
    controllerObservacionesPreCompra=TextEditingController(text: "");
    controllerFechaMovimiento=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva compra"),
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
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: Text("Registro atrazado"),
                              value: registroAtrazado, 
                              onChanged: (value){
                                setState(() {
                                  registroAtrazado=value!;
                                });
                              }
                            ),
                          ),
                          if(registroAtrazado)
                          Expanded(
                            child: TextFFOnTap(
                              controller: controllerFechaMovimiento!, 
                              label: "Fecha movimiento", 
                              onTap: ()async{
                                DateTime firstDate= DateTime(DateTime.now().year-5);
                                DateTime lastDate= DateTime(DateTime.now().year+5);
                                await pickDate(context,pickedDate!,firstDate,lastDate);
                                /*setState(() {
                                  pickedDate=date;
                                  //cp.fechaVencimiento="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                                  controllerFechaMovimiento!.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                                });*/
                                TimeOfDay timeOfDay=await pickTime(context, time);
                                setState(() {
                                  time=timeOfDay;
                                  controllerFechaMovimiento!.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()} ${time!.hour.toString().padLeft(2,'0')}:${time!.minute.toString().padLeft(2,'0')}";
                                });
                              } 
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFFBasico(
                              controller: controllerComprobante!, 
                              labelText: "N° comp. / fact.", 
                              onChanged: (x){
                                compraProvider.compraCarrito.nroComprobante=x;
                              }
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 5,),
                      if(proveedor.id!="")
                      Text("Proveedor"),
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
                                child: Text(proveedor.id==""?"Proveedor":"${proveedor.ciNit} | ${proveedor.nombres}"),
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
                                          proveedor=Proveedor.vacio();
                                          await dialogBuscarProveedor(context, proveedor);
                                          compraProvider.compraCarrito.proveedor=proveedor;
                                          setState(() {
                                            preCompraIniciada=false;
                                          });
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
                                          proveedor=Proveedor.vacio();
                                          bool respuesta=await dialogRegistroProveedor(context, proveedor, getOpcionOperacion.registrar.index);
                                          if(respuesta){
                                             useCaseProveedor.registrarProveedor(proveedor)
                                             .then((resultado){
                                               if(!resultado["completado"]){
                                                 proveedor=Proveedor.vacio();
                                               }else{
                                                 proveedor=resultado["proveedor"];
                                               }
                                               setState(() {
                                                 
                                              });
                                             });
                                          }else{
                                            setState(() {
                                              proveedor=Proveedor.vacio();
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
                      SizedBox(height: 5,),
                      TextFFBasico(
                        controller: controllerObservacionesPreCompra!, 
                        labelText: "Observaciones pre compra", 
                        onChanged: (x){
                          compraProvider.compraCarrito.observacionesPreCompra=x;
                          if(preCompraIniciada){
                            preCompraIniciada=!preCompraIniciada;
                            setState(() {
                              
                            });
                          }
                        }
                      ),
                      SizedBox(height: 5,),
                     /* if(preCompraIniciada)
                      ButtonRegistro(
                        color: preCompraIniciada?Colors.indigo.shade300:Colors.lightBlue,
                        texto: (!preCompraIniciada&&compraProvider.compra.id!="")?"Guardar cambios":"Iniciar pre compra", 
                        onPressed: (){
                          compraProvider.compra.tipoUsuarioConfirmacion=usuarioProvider.usuario.tipoUsuario=="Administrador"?"Vendedor":"Administrador";
                          compraProvider.compra.proveedor=proveedor;
                          compraProvider.compra.usuarioPreCompra=usuarioProvider.usuario;
                          if(compraProvider.compra.id==""){
                            useCaseCompra.registrarPreCompra(compraProvider.compra)
                            .then((resultado){
                              if(resultado["completado"]){
                                preCompraIniciada=!preCompraIniciada;
                                setState(() {
                                  
                                });
                              }
                            });  
                          }else{
                            useCaseCompra.modificarPreCompra(compraProvider.compra)
                            .then((completado){ 
                              if(completado){
                                preCompraIniciada=!preCompraIniciada;
                                setState(() {
                                  
                                });
                              }
                            });
                          }
                        }
                      ),*/
                      SizedBox(height: 5,),
                     // if(compraProvider.compra.id!="")
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border(
                            top:BorderSide(
                              color: Colors.black38,
                              width: 0.5
                            )
                          )
                        ),
                        child: HorizontalDataTableCompraProductos())
                    ],
                  )
                ),
                /*ButtonRegistro(
                  texto: "Terminar pre compra", 
                  onPressed: (){

                  }
                )*/
              ],
            ),
          ),
          
          ButtonFlotanteCompraRegitro()
        ],
      ),
    );
  }
}