import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/ui/pages/producto/page_producto_registro.dart';
import 'package:licoreriarocasapp/ui/provider/generales/categoriasProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:provider/provider.dart';
class PopupMenuItemCategorias extends StatefulWidget {
  PopupMenuItemCategorias({Key? key}) : super(key: key);
  @override
  _PopupMenuItemCategoriasState createState() => _PopupMenuItemCategoriasState();
}

class _PopupMenuItemCategoriasState extends State<PopupMenuItemCategorias> {
  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    return Container(
      child: Column(
        children: categoriasProvider.categorias.map((categoria){
          return Column(
            children: [
              ListTile(
                title: Text("${categoria.nombreCategoria}"),
                onTap: (){
                  categoriasProvider.setCategoria(categoria);
                  Navigator.pop(context);
                },
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
class PopupMenuItemSubcategorias extends StatefulWidget {
  PopupMenuItemSubcategorias({Key? key}) : super(key: key);

  @override
  _PopupMenuItemSubcategoriasState createState() => _PopupMenuItemSubcategoriasState();
}

class _PopupMenuItemSubcategoriasState extends State<PopupMenuItemSubcategorias> {
  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    return Container(
      child: Column(
        children: categoriasProvider.categoria.subcategorias.map((subcategoria){
          return Column(
            children: [
              ListTile(
                title: Text("${subcategoria.nombreSubcategoria}"),
                onTap: (){
                  categoriasProvider.setSubcategoria(subcategoria);
                  Navigator.pop(context);
                },
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
class PopupMenuItemEtiquetas extends StatefulWidget {
  PopupMenuItemEtiquetas({Key? key}) : super(key: key);

  @override
  _PopupMenuItemEtiquetasState createState() => _PopupMenuItemEtiquetasState();
}

class _PopupMenuItemEtiquetasState extends State<PopupMenuItemEtiquetas> {
  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    return Container(
      child: Column(
        children: categoriasProvider.subcategoria.etiquetas.map((etiqueta){
          return Column(
            children: [
              ListTile(
                title: Text("${etiqueta.nombreEtiqueta}"),
                onTap: (){
                  categoriasProvider.setEtiqueta(etiqueta);
                  Navigator.pop(context);
                },
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
class PopupMenuItemProducto extends StatefulWidget {
  PopupMenuItemProducto({Key? key,required this.producto}) : super(key: key);
  final Producto producto;
  @override
  _PopupMenuItemProductoState createState() => _PopupMenuItemProductoState();
}

class _PopupMenuItemProductoState extends State<PopupMenuItemProducto> {
  UseCaseProducto useCaseProducto=UseCaseProducto();
  @override
  Widget build(BuildContext context) {
    final productosProvider=Provider.of<ProductosProvider>(context);
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Modificar"),
            onTap: ()async{
              productosProvider.producto=widget.producto;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return PageProductoRegistro();
                  }
                )
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Eliminar"),
            onTap: ()async{
              useCaseProducto.eliminarProducto(widget.producto)
              .then((completado){
                productosProvider.productos.removeWhere((element) => element.id==widget.producto.id);
                productosProvider.notificar();
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}