
class Categoria{
  String id;
  String nombreCategoria;
  List<Subcategoria> subcategorias;
  bool seleccionado=false;
  Categoria({
    required this.id,
    required this.nombreCategoria,
    required this.subcategorias
  });
  factory Categoria.vacio(){
    return Categoria(id: "", nombreCategoria: "",subcategorias:[]);
  }
  factory Categoria.fromMap(Map<String,dynamic> data){
    List subcategoriasD=data["subcategorias"]??[];
    List<Subcategoria> subcat=[];
    subcategoriasD.forEach((data) { 
      subcat.add(Subcategoria.fromMap(data));
    });
    return Categoria(id: data["id"]??"", nombreCategoria: data["nombre_categoria"]??"",subcategorias: subcat);
  }
  factory Categoria.copyWith(Categoria c){
    List<Subcategoria> sc=[];
    c.subcategorias.forEach((e) { 
      sc.add(Subcategoria.copyWith(e));
    });
    return Categoria(
      id: c.id, nombreCategoria: c.nombreCategoria, subcategorias: sc);
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_categoria":this.nombreCategoria
    };
  }
}
class Subcategoria{
  String id;
  String nombreSubcategoria;
  List<Etiqueta> etiquetas;
  bool seleccionado=false;
  Categoria categoria;
  Subcategoria({required this.id,required this.nombreSubcategoria,required this.etiquetas,required this.categoria});
  factory Subcategoria.vacio(){
    return Subcategoria(id: "", nombreSubcategoria: "",etiquetas: [],categoria: Categoria.vacio());
  }
  factory Subcategoria.fromMap(Map<String,dynamic> data){
    
    List etiquetasD=data["etiquetas"]??[];
    List<Etiqueta> et=[];
    etiquetasD.forEach((data){
      et.add(Etiqueta.fromMap(data));
    });
    return Subcategoria(
      id: data["id"]??"", nombreSubcategoria: data["nombre_subcategoria"]??"",
      etiquetas: et,categoria: data["categoria"]!=null?Categoria.fromMap(data["categoria"]):Categoria.vacio()
    );
  }
  factory Subcategoria.copyWith(Subcategoria sc){
    List<Etiqueta> copiaEtiquetas=[];
    sc.etiquetas.forEach((e) { 
      copiaEtiquetas.add(Etiqueta.copyWith(e));
    });
    return Subcategoria(
      id: sc.id, nombreSubcategoria: sc.nombreSubcategoria, etiquetas: copiaEtiquetas,categoria: Categoria.copyWith(sc.categoria)
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "nombre_subcategoria":this.nombreSubcategoria
    };
  }
}
class Etiqueta{
  String id;
  String nombreEtiqueta;
  bool seleccionado=false;
  Subcategoria subcategoria;
  Etiqueta({
    required this.id,required this.nombreEtiqueta,required this.subcategoria
  });
  factory Etiqueta.vacio(){
    return Etiqueta(id: "", nombreEtiqueta: "",subcategoria: Subcategoria.vacio());
  }
  factory Etiqueta.fromMap(Map<String,dynamic> data){
    return Etiqueta(
      id: data["id"]??"", nombreEtiqueta: data["nombre_etiqueta"]??"",subcategoria: data["subcategoria"]!=null?Subcategoria.fromMap(data["subcategoria"]):Subcategoria.vacio()
    );
  }
  factory Etiqueta.copyWith(Etiqueta e){
    return Etiqueta(id: e.id, nombreEtiqueta: e.nombreEtiqueta,subcategoria: Subcategoria.copyWith(e.subcategoria));
  }
  Map<String,dynamic> toMap(){
    return<String,dynamic>{
      "id":this.id,
      "nombre_etiqueta":this.nombreEtiqueta
    };
  }
}