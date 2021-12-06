import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';

class CategoriasProvider extends ChangeNotifier{
  List<Categoria> categorias=[];
  Categoria categoria=Categoria.vacio();
  Subcategoria subcategoria=Subcategoria.vacio();
  Etiqueta etiqueta=Etiqueta.vacio();
  void setCategorias(List<Categoria> categorias){
    this.categoria=Categoria.vacio();
    
    this.subcategoria=Subcategoria.vacio();
    this.etiqueta=Etiqueta.vacio();
    this.categorias=categorias;
  }
  void setCategoria(Categoria categoria){
    this.categoria=categoria;
    this.subcategoria=Subcategoria.vacio();
    this.etiqueta=Etiqueta.vacio();
    notifyListeners();
  }
  void setSubcategoria(Subcategoria subcategoria){
    this.subcategoria=subcategoria;
    this.etiqueta=Etiqueta.vacio();
    notifyListeners();
  }
  void setEtiqueta(Etiqueta etiqueta){
    this.etiqueta=etiqueta;
    notifyListeners();
  }
}