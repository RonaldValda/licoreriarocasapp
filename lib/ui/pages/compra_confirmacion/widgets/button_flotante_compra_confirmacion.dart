import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_compra.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:provider/provider.dart';
class ButtonFlotanteCompraConfirmacion extends StatefulWidget {
  ButtonFlotanteCompraConfirmacion({Key? key}) : super(key: key);

  @override
  _ButtonFlotanteCompraConfirmacionState createState() => _ButtonFlotanteCompraConfirmacionState();
}

class _ButtonFlotanteCompraConfirmacionState extends State<ButtonFlotanteCompraConfirmacion> {
  double width=0.0;
  double height=0.0;
  UseCaseCompra useCaseCompra=UseCaseCompra();
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    width=MediaQuery.of(context).size.width-10;
    height=50;
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.all(5),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          
          //color: Colors.indigo
        ),
        child: Card(
          color: Colors.blue.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          elevation: 20,
          child: Row(
            mainAxisAlignment: usuarioProvider.usuario.tipoUsuario!="Vendedor"?MainAxisAlignment.spaceBetween:MainAxisAlignment.end,
            children: [
              if(usuarioProvider.usuario.tipoUsuario!="Vendedor")
              Row(
                children: [
                  Container(
                    child: Center(
                      child: Text("   Total: ${compraProvider.compraCarrito.costoTotal.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.amberAccent
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: width/6,
                    decoration:BoxDecoration(
                      //color: Colors.cyan.withOpacity(0.5),
                      //color: Colors.indigo
                    ),
                    child:MaterialButton(
                      /*shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                        )
                      ),*/
                      child: Tooltip(
                        message: "Confirmar pre compra",
                        child: Icon(Icons.check,size: 30,color: Colors.white70,),
                      ),
                      onPressed: (){
                        if(compraProvider.compraCarrito.fechaConfirmacionMovimiento==""){
                          compraProvider.compraCarrito.confirmado=true;
                          useCaseCompra.responderConfirmacionPreCompra(compraProvider.compraCarrito)
                          .then((resultado){
                            if(resultado["completado"]){
                              compraProvider.compraCarrito=resultado["compra"];
                              Navigator.pop(context);
                            }
                          });
                        }
                      }
                    )
                  ),
                  Container(
                    width: width/6,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                      ),
                    ),
                    child:MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)
                        )
                      ),
                      child: Tooltip(
                        message: "Rechazar pre compra",
                        child: Icon(Icons.close,size: 30,color: Colors.white70,),
                      ),
                      onPressed: (){
                        if(compraProvider.compraCarrito.fechaConfirmacionMovimiento==""){
                          compraProvider.compraCarrito.confirmado=true;
                          useCaseCompra.responderConfirmacionPreCompra(compraProvider.compraCarrito)
                          .then((resultado){
                            if(resultado["completado"]){
                              compraProvider.compraCarrito=resultado["compra"];
                              Navigator.pop(context);
                            }
                          });
                        }
                      }
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}