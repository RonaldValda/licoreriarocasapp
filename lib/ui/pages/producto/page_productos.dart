import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_categoria.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/ui/pages/producto/page_producto_registro.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/horizontal_data_table_productos.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/popup_menu_button.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/popup_menu_item.dart';
import 'package:licoreriarocasapp/ui/provider/generales/categoriasProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:provider/provider.dart';
class PageProductos extends StatefulWidget {
  PageProductos({Key? key}) : super(key: key);

  @override
  _PageProductosState createState() => _PageProductosState();
}

class _PageProductosState extends State<PageProductos> {
  late CategoriasProvider catProvider;
  UseCaseCategoria useCaseCategoria=UseCaseCategoria();
  UseCaseProducto useCaseProducto=UseCaseProducto();
  ScrollController controllerHorizontal=ScrollController();
  List<Producto> productos=[];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      catProvider=Provider.of<CategoriasProvider>(context,listen: false);
      useCaseCategoria.obtenerCategorias()
      .then((resultado){
        if(resultado["completado"]){
          catProvider.setCategorias(resultado["categorias"]);
          setState(() {
            
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    final productosProvider=Provider.of<ProductosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
        elevation: 4,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                    child: ListView(
                      padding:EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.horizontal,
                      children: [
                        
                        PopupMenuButtonCategoria(),
                        SizedBox(width: 5,),
                        PopupMenuButtonSubcategoria(),
                        SizedBox(width: 5,),
                        PopupMenuButtonEtiqueta()
                      ],
                    ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(00),
                border: Border.all(style: BorderStyle.solid,color: Colors.black26,width: 1)
              ),
              child: MaterialButton(
                onPressed: ()async{
                  useCaseProducto.obtenerProductos(categoriasProvider.etiqueta.id)
                  .then((resultado) {
                    if(resultado["completado"]){
                      productos=resultado["productos"];
                      productosProvider.productos=[];
                      productosProvider.productos.addAll(resultado["productos"]);
                      print(productosProvider.productos.length);
                      productosProvider.notificar();
                      setState(() {
                        
                      });
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Buscar")
                  ],
                ),
              ),
            ),
            Expanded(
              child: HorizontalDataTableProductos()
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          productosProvider.producto=Producto.vacio();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return PageProductoRegistro();
              }
            )
          );
          /*if(productosProvider.producto.id!=""){
            productosProvider.productos.add(productosProvider.producto);
            productosProvider.notificar();
          }*/
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
