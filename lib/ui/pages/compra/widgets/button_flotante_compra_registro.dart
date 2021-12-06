import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/ui/pages/compra/widgets/dialog_buscar_producto.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:provider/provider.dart';
class ButtonFlotanteCompraRegitro extends StatefulWidget {
  ButtonFlotanteCompraRegitro({Key? key}) : super(key: key);

  @override
  _ButtonFlotanteCompraRegitroState createState() => _ButtonFlotanteCompraRegitroState();
}

class _ButtonFlotanteCompraRegitroState extends State<ButtonFlotanteCompraRegitro> {
  double width=0.0;
  double height=0.0;
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
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