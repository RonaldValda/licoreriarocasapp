import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
class ProductoKardexProvider extends ChangeNotifier{
  List<ProductoKardex> productoKardexs=[];
  void setProductoKardexs(List<ProductoKardex> productoKardexs,{bool notificar=true}){
    this.productoKardexs=productoKardexs;
    if(notificar)notifyListeners();
  }
}