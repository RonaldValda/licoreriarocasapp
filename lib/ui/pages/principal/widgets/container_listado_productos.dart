
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/ui/pages/compra_registro/page_compra_registro.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class ContainerListadoProductosCompra extends StatefulWidget {
  ContainerListadoProductosCompra({Key? key}) : super(key: key);

  @override
  _ContainerListadoProductosCompraState createState() => _ContainerListadoProductosCompraState();
}

class _ContainerListadoProductosCompraState extends State<ContainerListadoProductosCompra> {
  UseCaseProducto useCaseProducto=UseCaseProducto();
  List<Producto> productos=[];
  List<CompraProducto> compraProductos=[];
  //late CompraProvider cmpProvider;
  //late UsuarioProvider usProvider;
  double widthInfoCompra=0.0;
  double heightInfoCompra=0.0;
  @override
  void initState() {
    super.initState();
    /*WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      cmpProvider=Provider.of<CompraProvider>(context,listen: false);
      usProvider=Provider.of<UsuarioProvider>(context,listen: false);
      cmpProvider.compraCarrito.usuarioPreCompra=usProvider.usuario;
      cmpProvider.setCompra(Compra.vacio());
      useCaseProducto.obtenerProductosGeneral()
      .then((resultado){
        if(resultado["completado"]){
          productos=resultado["productos"];
          productos.forEach((producto) {
            CompraProducto cp=CompraProducto.vacio();
            cp.producto=producto;
            cmpProvider.compra.compraProductos.add(cp);
          });
          
          setState(() {
            
          });
        }
      });
    });*/
    
  }
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    final productoProvider=Provider.of<ProductosProvider>(context);
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    widthInfoCompra=MediaQuery.of(context).size.width-20;
    heightInfoCompra=40;
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          //Expanded(
            //child:
             GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width/(MediaQuery.of(context).size.width*1.5),
                crossAxisSpacing: 5,
                mainAxisSpacing: 10
              ),
              itemCount: compraProvider.compra.compraProductos.length,
              itemBuilder: (context, index) {
                return _itemCompraProducto(compraProvider, index);
              },
            ),
            if(compraProvider.compraCarrito.compraProductos.length>0)
            _containerInfoPreCompra(compraProvider,usuarioProvider)
          //)
        ],
      ),
    );
  }
  Widget _containerInfoPreCompra(CompraProvider compraProvider,UsuarioProvider usuarioProvider){
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
          color: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("  Cantidad productos: ${compraProvider.compraCarrito.compraProductos.length}",
                style: TextStyle(
                  color: Colors.white70,

                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/4,
                height: heightInfoCompra,
                child: MaterialButton(
                  onPressed: (){
                    compraProvider.compraCarrito.usuarioPreCompra=usuarioProvider.usuario;
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return PageCompraRegistro();
                      }
                    )
                  );
                  },
                  child:Icon(Icons.monetization_on,color: Colors.white70,)
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  Widget  _itemCompraProducto(CompraProvider compraProvider,int index){
    var compraProducto=compraProvider.compra.compraProductos[index];
    TextEditingController controllerCantidad=TextEditingController(text: compraProducto.cantidad.toString());
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
                    
                    imageUrl: compraProducto.producto.imagenesProducto[0]
                  ),
                ),
                Text("${compraProducto.producto.contenido.toString()}"),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width/2/4,
                        height: MediaQuery.of(context).size.width/2/6,
                        decoration: BoxDecoration(
                          color: Colors.grey,
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
                            if(compraProducto.cantidad>0){
                              controllerCantidad.text=(int.parse(controllerCantidad.text)-1).toString();
                              compraProducto.cantidad=int.parse(controllerCantidad.text);
                            }
                          }
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          child: TextFFBasico(
                            controller: controllerCantidad, 
                            labelText: "", 
                            textAlign: TextAlign.center,
                            onChanged: (x){
                              if(int.parse(x)>=0){
                                compraProducto.cantidad=int.parse(x);
                              }else{
                                controllerCantidad.text="0";
                              }
                            }
                          ),
                        )
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width/2/4,
                        height: MediaQuery.of(context).size.width/2/6,
                        decoration: BoxDecoration(
                          color: Colors.grey,
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
                            controllerCantidad.text=(int.parse(controllerCantidad.text)+1).toString();
                            compraProducto.cantidad=int.parse(controllerCantidad.text);
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)
                )
              ),
              child: MaterialButton(
                onPressed: (){
                  print(compraProducto.producto.precio);
                  if(compraProducto.seleccionado){
                    compraProducto.seleccionado=!compraProducto.seleccionado;
                    compraProvider.removeCompraProductoCarrito(compraProducto);
                  }else{
                    compraProducto.seleccionado=!compraProducto.seleccionado;
                    compraProvider.addCompraProductoCarrito(compraProducto);
                  }
                },
                child: //Icon(Icons.add_shopping_cart,color: Colors.amberAccent,)
                Text(!compraProducto.seleccionado?"Añadir a carrito":"Quitar de carrito",
                  style: TextStyle(
                    color: !compraProducto.seleccionado?Colors.indigo:Colors.red
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}