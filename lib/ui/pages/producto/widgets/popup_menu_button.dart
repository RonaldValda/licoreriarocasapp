import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/popup_menu_item.dart';
import 'package:licoreriarocasapp/ui/provider/generales/categoriasProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:provider/provider.dart';
class PopupMenuButtonCategoria extends StatelessWidget {
  const PopupMenuButtonCategoria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    return PopupMenuButton(
      tooltip: "Categorías",
      elevation: 30,
      offset: const Offset(0, -35),
      color: Colors.white.withOpacity(0.8),
      child: Row(
        children: [
          Icon(Icons.check_box,size: 20,),
          Container(
            child: 
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height:32,
                    child:Container(
                      alignment: Alignment.center,
                      width: categoriasProvider.categoria.nombreCategoria.toString().length<10?72:categoriasProvider.categoria.nombreCategoria.toString().length.toDouble()*8.2,
                      child: Text(categoriasProvider.categoria.nombreCategoria,
                        textAlign: TextAlign.right,
                        style:TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal
                        )
                      ),
                    )
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black,width: 0.2)
                )
              ),
          ),
        ],
      ),
      onCanceled: (){
        
      },
      padding: EdgeInsets.zero,
      itemBuilder: (context){
        return[
          PopupMenuItem<int>(
            padding: EdgeInsets.all(0),
            value: 0, 
            child: PopupMenuItemCategorias()
          ),
        ];
      }
    );
  }
}
class PopupMenuButtonSubcategoria extends StatelessWidget {
  const PopupMenuButtonSubcategoria({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    return PopupMenuButton(
      tooltip: "Subcategoría",
      elevation: 30,
      offset: const Offset(0, -35),
      color: Colors.white.withOpacity(0.8),
      child: Row(
        children: [
          Icon(Icons.check_box,size: 20,),
          Container(
            child: 
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height:32,
                    child:Container(
                      alignment: Alignment.center,
                      width: categoriasProvider.subcategoria.nombreSubcategoria.toString().length<10?72:categoriasProvider.subcategoria.nombreSubcategoria.toString().length.toDouble()*8.2,
                      child: Text(categoriasProvider.subcategoria.nombreSubcategoria,
                        textAlign: TextAlign.right,
                        style:TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal
                        )
                      ),
                    )
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black,width: 0.2)
                )
              ),
          ),
        ],
      ),
      padding: EdgeInsets.zero,
      itemBuilder: (context){
        return[
          PopupMenuItem<int>(
            padding: EdgeInsets.all(0),
            value: 0, 
            child: PopupMenuItemSubcategorias()
          ),
        ];
      }
    );
  }
}
class PopupMenuButtonEtiqueta extends StatelessWidget {
  const PopupMenuButtonEtiqueta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    return PopupMenuButton(
      tooltip: "Etiqueta",
      elevation: 30,
      offset: const Offset(0, -35),
      color: Colors.white.withOpacity(0.8),
      child: Row(
        children: [
          Icon(Icons.check_box,size: 20,),
          Container(
            child: 
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height:32,
                    child:Container(
                      alignment: Alignment.center,
                      width: categoriasProvider.etiqueta.nombreEtiqueta.toString().length<10?72:categoriasProvider.etiqueta.nombreEtiqueta.toString().length.toDouble()*8.2,
                      child: Text(categoriasProvider.etiqueta.nombreEtiqueta,
                        textAlign: TextAlign.right,
                        style:TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal
                        )
                      ),
                    )
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black,width: 0.2)
                )
              ),
          ),
        ],
      ),
      padding: EdgeInsets.zero,
      itemBuilder: (context){
        return[
          PopupMenuItem<int>(
            padding: EdgeInsets.all(0),
            value: 0, 
            child: PopupMenuItemEtiquetas()
          ),
        ];
      }
    );
  }
}
class PopupMenuButtonProducto extends StatelessWidget {
  const PopupMenuButtonProducto({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productosProvider=Provider.of<ProductosProvider>(context);
    return PopupMenuButton(
      tooltip: "Producto",
      elevation: 30,
      offset: const Offset(0, -35),
      color: Colors.white.withOpacity(0.8),
      child: Row(
        children: [
          Icon(Icons.check_box,size: 20,),
          Container(
            child: 
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height:32,
                    child:Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width-50,
                      child: Text(productosProvider.producto.contenido,
                        textAlign: TextAlign.right,
                        style:TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal
                        )
                      ),
                    )
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black,width: 0.2)
                )
              ),
          ),
        ],
      ),
      padding: EdgeInsets.zero,
      itemBuilder: (context){
        return[
          PopupMenuItem<int>(
            padding: EdgeInsets.all(0),
            value: 0, 
            child: PopupMenuItemProductos()
          ),
        ];
      }
    );
  }
}