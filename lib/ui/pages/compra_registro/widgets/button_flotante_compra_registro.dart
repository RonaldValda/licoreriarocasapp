import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_compra.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:provider/provider.dart';
class ButtonFlotanteCompraRegitro extends StatefulWidget {
  ButtonFlotanteCompraRegitro({Key? key}) : super(key: key);

  @override
  _ButtonFlotanteCompraRegitroState createState() => _ButtonFlotanteCompraRegitroState();
}

class _ButtonFlotanteCompraRegitroState extends State<ButtonFlotanteCompraRegitro> {
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
          color: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          elevation: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Container(
                width: width/2,
                decoration:BoxDecoration(
                  
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                  ),
                  //color: Colors.indigo
                ),
                child:MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                    )
                  ),
                  child: Text("Registrar",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.amberAccent
                    ),
                  ),
                  onPressed: (){
                    compraProvider.compraCarrito.sucursal=usuarioProvider.sucursal;
                    compraProvider.compraCarrito.usuarioPreCompra=usuarioProvider.usuario;
                    compraProvider.compraCarrito.tipoUsuarioConfirmacion=usuarioProvider.usuario.tipoUsuario=="Administrador"?"Vendedor":"Administrador";
                    useCaseCompra.registrarPreCompra(compraProvider.compraCarrito)
                    .then((resultado){
                      if(resultado["completado"]){
                        compraProvider.compraCarrito=resultado["compra"];
                        compraProvider.compraCarrito.compraProductos.forEach((element) { 
                          element.seleccionado=false;
                          element.cantidad=0;
                          element.precioUnitario=0;
                          element.lote="";
                          element.fechaVencimiento="";
                        });
                        compraProvider.setCompraCarrito(Compra.vacio());
                        Navigator.pop(context);
                      }
                    });
                  }
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}