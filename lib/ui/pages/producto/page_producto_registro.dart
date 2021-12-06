import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/container_imagen_producto_registro.dart';
import 'package:licoreriarocasapp/ui/provider/generales/categoriasProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/button_registro.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class PageProductoRegistro extends StatefulWidget {
  PageProductoRegistro({Key? key
  }) : super(key: key);

  @override
  _PageProductoRegistroState createState() => _PageProductoRegistroState();
}

class _PageProductoRegistroState extends State<PageProductoRegistro> {
  TextEditingController? controllerCodigo;
  TextEditingController? controllerContenido;
  TextEditingController? controllerUnidad;
  TextEditingController? controllerPrecio;
  TextEditingController? controllerStockMinimo;
  TextEditingController? controllerUtilidad;
  TextEditingController? controllerVencimientoMaximo;
  TextEditingController? controllerGradoAlcoholico;
  UseCaseProducto useCaseProducto=UseCaseProducto();
  double heigthDivider=5;
  @override
  void initState() {
    super.initState();
    controllerCodigo=TextEditingController(text: "");
    controllerContenido=TextEditingController(text: "");
    controllerUnidad=TextEditingController(text: "");
    controllerPrecio=TextEditingController(text: "");
    controllerStockMinimo=TextEditingController(text: "");
    controllerUtilidad=TextEditingController(text: "");
    controllerVencimientoMaximo=TextEditingController(text: "");
    controllerGradoAlcoholico=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final productosProvider=Provider.of<ProductosProvider>(context);
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    if(controllerContenido!.text==""){
      controllerCodigo!.text=productosProvider.producto.codigo;
      controllerContenido!.text=productosProvider.producto.contenido;
      controllerUnidad!.text=productosProvider.producto.unidad;
      controllerPrecio!.text=productosProvider.producto.precio.toString();
      controllerStockMinimo!.text=productosProvider.producto.stockMinimo.toString();
      controllerUtilidad!.text=productosProvider.producto.utilidad.toString();
      controllerVencimientoMaximo!.text=productosProvider.producto.vencimientoMaximo.toString();
      controllerGradoAlcoholico!.text=productosProvider.producto.gradoAlcoholico.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(productosProvider.producto.id!=""?"Datos del producto":"Nuevo producto"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.all(5),
                children: [
                  ContainerImagenProductoRegistro(),
                  TextFFBasico(
                    controller: controllerCodigo!, 
                    labelText: "Código de barras o QR", 
                    onChanged: (x){
                      productosProvider.producto.codigo=x;
                    }
                  ),
                  Divider(height: heigthDivider,),
                  TextFFBasico(
                    controller: controllerContenido!, 
                    labelText: "Contenido", 
                    onChanged: (x){
                      productosProvider.producto.contenido=x;
                    }
                  ),
                  Divider(height: heigthDivider,),
                  TextFFBasico(
                    controller: controllerUnidad!, 
                    labelText: "Unidad", 
                    onChanged: (x){
                      productosProvider.producto.unidad=x;
                    }
                  ),
                  Divider(height: heigthDivider,),
                  TextFFBasico(
                    controller: controllerPrecio!, 
                    labelText: "Precio", 
                    onChanged: (x){
                      productosProvider.producto.precio=double.parse(x);
                    }
                  ),
                  Divider(height: heigthDivider,),
                  TextFFBasico(
                    controller: controllerStockMinimo!, 
                    labelText: "Stock mínimo", 
                    onChanged: (x){
                      productosProvider.producto.stockMinimo=int.parse(x);
                    }
                  ),
                  Divider(height: heigthDivider,),
                  TextFFBasico(
                    controller: controllerUtilidad!, 
                    labelText: "Utilidad", 
                    onChanged: (x){
                      productosProvider.producto.utilidad=double.parse(x);
                    }
                  ),
                  Divider(height: heigthDivider,),
                  TextFFBasico(
                    controller: controllerVencimientoMaximo!, 
                    labelText: "Vencimiento máximo", 
                    onChanged: (x){
                      productosProvider.producto.vencimientoMaximo=int.parse(x);
                    }
                  ),
                  Divider(height: heigthDivider,),
                  TextFFBasico(
                    controller: controllerGradoAlcoholico!, 
                    labelText: "Grado alcohólico", 
                    onChanged: (x){
                      productosProvider.producto.gradoAlcoholico=double.parse(x);
                    }
                  ),
                ],
              ),
            ),
            ButtonRegistro(
              texto: productosProvider.producto.id!=""?"Modificar":"Registrar", 
                onPressed: ()async{
                  if(productosProvider.producto.id==""){
                  useCaseProducto.registrarProducto(categoriasProvider.etiqueta.id, productosProvider.producto)
                  .then((resultado){
                    if(resultado["completado"]){
                      productosProvider.productos.add(productosProvider.producto);
                      productosProvider.notificar();
                      Navigator.pop(context);
                    }
                  });
                }else{
                  useCaseProducto.modificarProducto(productosProvider.producto)
                  .then((completado){
                    if(completado){
                      productosProvider.productos.removeWhere((element) => element.id==productosProvider.producto.id);
                      productosProvider.productos.add(productosProvider.producto);
                      Navigator.pop(context);
                    }
                  });
                }
              }
            )
          ],
        ),
      ),
    );
  }
}