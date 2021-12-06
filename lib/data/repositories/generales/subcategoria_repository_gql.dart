String getMutationRegistrarSubcategoria(){
  String query="";
  query=r"""
  mutation registrarSubcategoria(
    $id_categoria:ID
    $nombre_subcategoria:String
  ){
    registrarSubcategoria(
      id_categoria:$id_categoria
      nombre_subcategoria:$nombre_subcategoria
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarSubcategoria(){
  String query="";
  query=r"""
  mutation modificarSubcategoria(
    $id:ID
    $nombre_subcategoria:String
  ){
    modificarSubcategoria(
      id:$id
      nombre_subcategoria:$nombre_subcategoria
    )
  }
  """;
  return query;
}
String getMutatioEliminarSubcategoria(){
  String query="";
  query=r"""
  mutation eliminarSubcategoria(
    $id:ID
  ){
    eliminarSubcategoria(
      id:$id
    )
  }
  """;
  return query;
}
