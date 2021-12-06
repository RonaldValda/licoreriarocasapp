import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/imagenes/usecase_imagenes.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:licoreriarocasapp/ui/utils/imagen_utils.dart';
import 'package:provider/provider.dart';
import 'package:image_cropper/image_cropper.dart';
class GrillaImagenes extends StatefulWidget {
  GrillaImagenes({Key? key,required this.uploading}) : super(key: key);
  final bool uploading;
  
  @override
  _GrillaImagenesState createState() => _GrillaImagenesState();
}

class _GrillaImagenesState extends State<GrillaImagenes> {
  bool exterioresSeleccionado=false;
  double widthImagen=0;
  double marginImagen=0;
  bool modoVertical=true;
  bool isGallery=true;
  UseCaseImagenes useCaseImagenes=UseCaseImagenes();

  @override
  Widget build(BuildContext context) {
    final productosProvider=Provider.of<ProductosProvider>(context);
    widthImagen=MediaQuery.of(context).size.width/2;
    marginImagen=5;
    modoVertical=MediaQuery.of(context).size.height>MediaQuery.of(context).size.width?true:false;
    
    return GridView.builder(
      itemCount: productosProvider.producto.imagenesProducto.length+1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: modoVertical?2:4),
      itemBuilder: (context,index){
        return 
            Container(
              padding: EdgeInsets.all(0),
              child: Column(
                verticalDirection: VerticalDirection.down,
                children:<Widget>[
                  index==0?
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(marginImagen),
                      color: Colors.grey,
                      width: widthImagen,
                      height: widthImagen,
                      child: IconButton(
                        onPressed:() {onPressedUploadImage(productosProvider);},
                       icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 60,
                        )),
                    ),
                  ):                
                  Expanded(
                    child: InkWell(
                      onLongPress: (){
                        setState(() {
                          exterioresSeleccionado=true;
                        });
                      },
                      onTap:(){
                        setState(() {
                          exterioresSeleccionado=false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        height: widthImagen,
                        margin: EdgeInsets.all(marginImagen),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(productosProvider.producto.imagenesProducto[index-1] as String),
                            fit: BoxFit.cover
                          ),
                        ),
                             
                        child:  exterioresSeleccionado?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white.withOpacity(0.5),
                              width:30,
                              height:30,
                              child:  Container(
                                color: Colors.white.withOpacity(0.5),
                                width:30,
                                height:30,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: (){
                                   //borrarImage(widget.imagenes,index-1);
                                    setState(() {
                                      
                                    });
                                }, icon: Icon(Icons.delete,color: Colors.red,)),
                              ),
                            ),
                          ],
                        ):Container(),
                      ),
                    ),
                  )
              ]),
            );
      }
    );
  }
  void onPressedUploadImage(ProductosProvider productosProvider) async{
    final file=await ImagenUtils.pickMedia(
      isGallery: isGallery,
      cropImage: useCaseImagenes.cropCustomImage,
    );
    if(file==null) return;
    setState(() {
      
    });
    useCaseImagenes.subirImagen(file).then((url){
      productosProvider.addImagenProducto(url);
    }).whenComplete(() {
      setState(() {
        
      });
    });
  }
}