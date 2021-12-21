import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/compra_confirmacion/widgets/button_flotante_compra_confirmacion.dart';
import 'package:licoreriarocasapp/ui/pages/compra_registro/widgets/horizontal_data_table_compra_productos.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class PageCompraConfirmacion extends StatefulWidget {
  PageCompraConfirmacion({Key? key}) : super(key: key);

  @override
  _PageCompraConfirmacionState createState() => _PageCompraConfirmacionState();
}

class _PageCompraConfirmacionState extends State<PageCompraConfirmacion> {
  TextEditingController? controllerUsuarioPreCompra;
  TextEditingController? controllerComprobante;
  TextEditingController? controllerProveedor;
  TextEditingController? controllerObservacionesPreCompra;
  TextEditingController? controllerObservacionesConfirmacion;
  late CompraProvider cmProvider;
  @override
  void initState() {
    super.initState();
    controllerUsuarioPreCompra=TextEditingController(text: "");
    controllerComprobante=TextEditingController(text: "");
    controllerProveedor=TextEditingController(text: "");
    controllerObservacionesPreCompra=TextEditingController(text: "");
    controllerObservacionesConfirmacion=TextEditingController(text: "");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      cmProvider=Provider.of<CompraProvider>(context,listen: false);
      controllerUsuarioPreCompra!.text= "${cmProvider.compraCarrito.usuarioPreCompra.nombres} ${cmProvider.compraCarrito.usuarioPreCompra.apellidos}";
      controllerComprobante!.text=cmProvider.compraCarrito.nroComprobante;
      controllerProveedor!.text="${cmProvider.compraCarrito.proveedor.ciNit} | ${cmProvider.compraCarrito.proveedor.nombres}";
      controllerObservacionesPreCompra!.text=cmProvider.compraCarrito.observacionesPreCompra;
      controllerObservacionesConfirmacion!.text=cmProvider.compraCarrito.observacionesConfirmacion;
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmación de compra"),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(left: 5,right:5,top: 10,bottom: 5),
              children: [
                TextFFBasico(
                  isEnabled: true,
                  controller: controllerUsuarioPreCompra!, 
                  labelText: "${compraProvider.compraCarrito.usuarioPreCompra.tipoUsuario}", 
                  onChanged: (x){
                  }
                ),
                SizedBox(height: 5,),
                TextFFBasico(
                  isEnabled: false,
                  controller: controllerComprobante!, 
                  labelText: "N° de comprobante / factura", 
                  onChanged: (x){
                  }
                ),
                SizedBox(height: 5,),
                TextFFBasico(
                  isEnabled: false,
                  controller: controllerProveedor!, 
                  labelText: "Proveedor", 
                  onChanged: (x){
                  }
                ),
                SizedBox(height: 5,),
                TextFFBasico(
                  isEnabled: false,
                  controller: controllerObservacionesPreCompra!, 
                  labelText: "Observaciones (Pre compra)", 
                  onChanged: (x){
                  }
                ),
                SizedBox(height: 5,),
                TextFFBasico(
                  controller: controllerObservacionesConfirmacion!, 
                  labelText: "Observaciones (Confirmación)", 
                  onChanged: (x){
                    compraProvider.compraCarrito.observacionesConfirmacion=x;
                  }
                ),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-360,
                  decoration: BoxDecoration(
                    border: Border(
                      top:BorderSide(
                        color: Colors.black38,
                        width: 0.5
                      )
                    )
                  ),
                  child: HorizontalDataTableCompraProductos()
                )
              ],
            ),
            ButtonFlotanteCompraConfirmacion()
          ],
        ),
      ),
    );
  }
}