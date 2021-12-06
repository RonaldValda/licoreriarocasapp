import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';

class ProductosProvider extends ChangeNotifier{
  List<Producto> productos=[];
  Producto producto=Producto.vacio();
  void setProductos(List<Producto> productos){
    this.productos=productos;
    notifyListeners();
  }
  void setProducto(Producto producto){
    this.producto=producto;
    notifyListeners();
  }
  void addImagenProducto(dynamic imagen){
    this.producto.imagenesProducto.add(imagen);
    notifyListeners();
  }
  void notificar(){
    notifyListeners();
  }
}