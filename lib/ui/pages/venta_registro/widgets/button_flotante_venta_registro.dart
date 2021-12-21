import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_compra.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/provider/venta/ventaProvider.dart';
import 'package:provider/provider.dart';
class ButtonFlotanteVentaRegitro extends StatefulWidget {
  ButtonFlotanteVentaRegitro({Key? key}) : super(key: key);

  @override
  _ButtonFlotanteVentaRegitroState createState() => _ButtonFlotanteVentaRegitroState();
}

class _ButtonFlotanteVentaRegitroState extends State<ButtonFlotanteVentaRegitro> {
  double width=0.0;
  double height=0.0;
  @override
  Widget build(BuildContext context) {
    final ventaProvider=Provider.of<VentaProvider>(context);
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
          color: Colors.greenAccent,
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
                      child: Text("   Total: ${ventaProvider.ventaCarrito.precioTotal.toString()}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16
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
                  child: Text("Vender",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16
                    ),
                  ),
                  onPressed: (){
                    ventaProvider.ventaCarrito.sucursal=usuarioProvider.sucursal;
                    ventaProvider.ventaCarrito.vendedor=usuarioProvider.usuario;
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