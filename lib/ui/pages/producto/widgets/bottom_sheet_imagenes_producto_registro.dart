import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/grilla_imagenes_producto_registro.dart';
Future<dynamic> shorwModalBotonSheetImagenes(
  BuildContext context,List<dynamic> imagenes,bool uploading,
) {
    return showModalBottomSheet(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10),),
      ),
      elevation: 50,
      context: context,
      isDismissible: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(right: 5,left: 5,top: 0,bottom: 5),
          height: MediaQuery.of(context).size.height/1.1,
          child: Column(
            children: [
              Container(
                height: 30,
                padding: EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Seleccione las imágenes",
                      style: TextStyle(
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    IconButton(
                      splashRadius: 25,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)
                    )
                  ],
                ),
              ),
              Expanded(
                child: GrillaImagenes(
                  uploading: uploading,
                )
              )
            ],
          ),
        );
      },
    );
  }