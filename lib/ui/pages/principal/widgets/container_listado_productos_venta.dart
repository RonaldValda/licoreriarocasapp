import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/venta_registro/page_venta_registro.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/provider/venta/ventaProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class ContainerListadoProductosVenta extends StatefulWidget {
  ContainerListadoProductosVenta({Key? key}) : super(key: key);

  @override
  _ContainerListadoProductosVentaState createState() => _ContainerListadoProductosVentaState();
}

class _ContainerListadoProductosVentaState extends State<ContainerListadoProductosVenta> {
  double widthInfoCompra=0.0;
  double heightInfoCompra=0.0;
  @override
  Widget build(BuildContext context) {
    final ventaProvider=Provider.of<VentaProvider>(context);
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    widthInfoCompra=MediaQuery.of(context).size.width-20;
    heightInfoCompra=40;
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.width*1.4),
              crossAxisSpacing: 5,
              mainAxisSpacing: 10
            ),
            itemCount: ventaProvider.venta.ventaProductos.length,
            itemBuilder: (context, index) {
              return _itemVentaProducto(ventaProvider, index);
            },
          ),
          if(ventaProvider.ventaCarrito.ventaProductos.length>0)
            _containerInfoVenta(ventaProvider,usuarioProvider)
        ],
      ),
    );
  }
  Widget _containerInfoVenta(VentaProvider ventaProvider,UsuarioProvider usuarioProvider){
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: widthInfoCompra,
        height: heightInfoCompra,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("  Ítems: ${ventaProvider.ventaCarrito.ventaProductos.length}",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16
                ),
              ),
              Text("  Total: ${ventaProvider.ventaCarrito.precioTotal} BoB",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/4,
                height: heightInfoCompra,
                child: MaterialButton(
                  onPressed: (){
                    ventaProvider.ventaCarrito.vendedor=usuarioProvider.usuario;
                   // compraProvider.compraCarrito.usuarioPreCompra=usuarioProvider.usuario;
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return PageVentaRegistro();
                      }
                    )
                  );
                  },
                  child:Icon(Icons.monetization_on,color: Colors.black54,)
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  Widget  _itemVentaProducto(VentaProvider ventaProvider,int index){
    var ventaProducto=ventaProvider.venta.ventaProductos[index];
    TextEditingController controllerCantidad=TextEditingController(text: ventaProducto.cantidad.toString());
    controllerCantidad.value=controllerCantidad.value.copyWith(
      text: ventaProducto.cantidad.toString(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: ventaProducto.cantidad.toString().length)),
    );
    return Card(
      elevation: 5,
      borderOnForeground: true,
      semanticContainer: true,
      shadowColor: Colors.indigoAccent,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 2/1.8,
                  child: CachedNetworkImage(
                    imageUrl: ventaProducto.producto.imagenesProducto[0]
                  ),
                ),
                Text("${ventaProducto.producto.contenido.toString()}"),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width/2/4,
                        height: MediaQuery.of(context).size.width/2/6,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: MaterialButton(
                          child: Text("-",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.amberAccent
                            ),
                          ),
                          onPressed: (){
                            ventaProvider.decrementarCantidadVentaProductoCarrito(ventaProducto);
                          }
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          child: TextFFBasicoNumeros(
                            controller: controllerCantidad, 
                            labelText: "", 
                            fontSize: 18,
                            textAlign: TextAlign.center,
                            onChanged: (x){
                              ventaProvider.setCantidadVentaProductoCarrito(ventaProducto, x!=""?int.parse(x):0);
                            }
                          ),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width/2/4,
                        height: MediaQuery.of(context).size.width/2/6,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        child: MaterialButton(
                          child: Text("+",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.amberAccent
                            ),
                          ),
                          onPressed: (){
                            ventaProvider.incrementarCantidadVentaProductoCarrito(ventaProducto);
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}