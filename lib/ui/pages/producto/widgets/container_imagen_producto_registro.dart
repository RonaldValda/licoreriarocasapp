import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/bottom_sheet_imagenes_producto_registro.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:provider/provider.dart';
class ContainerImagenProductoRegistro extends StatefulWidget {
  ContainerImagenProductoRegistro({Key? key}) : super(key: key);

  @override
  _ContainerImagenProductoRegistroState createState() => _ContainerImagenProductoRegistroState();
}

class _ContainerImagenProductoRegistroState extends State<ContainerImagenProductoRegistro> {
  bool uploading=false;
  List<dynamic> imagenes=[];
  @override
  Widget build(BuildContext context) {
    final productosProvider=Provider.of<ProductosProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width/1.5,
      height: MediaQuery.of(context).size.width/1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Card(
                elevation: 2,
                borderOnForeground: false,
                shadowColor: Colors.white70,
                semanticContainer: false,
                color: Colors.grey,
                child: Container(
                  width: MediaQuery.of(context).size.width/1.6,
                  height: MediaQuery.of(context).size.width/1.6,
                  color: Colors.black26,
                  child:PageView.builder(
                    itemCount: productosProvider.producto.imagenesProducto.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: CachedNetworkImage(
                          imageUrl: productosProvider.producto.imagenesProducto[index]
                        ),
                      );
                    },
                  )
                ),
              ),
              Positioned(
                top: 5,
                left:5,
                child: Container(
                  //margin: EdgeInsets.all(10),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                  ),
                  child:MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: ()async{
                      imagenes=[];
                      shorwModalBotonSheetImagenes(context, imagenes, uploading);
                      //imagenes.addAll(inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes[widget.clave]);
                    },
                    child: Tooltip(
                      message: "Subir imágen",
                      child: Icon(Icons.add_a_photo,color: Colors.white54,),
                    )
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}