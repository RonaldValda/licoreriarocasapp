String getMutationRegistrarEtiqueta(){
  String query="";
  query=r"""
  mutation registrarEtiqueta(
    $id_subcategoria:ID,
    $nombre_etiqueta:String
  ){
    registrarEtiqueta(
      id_subcategoria:$id_subcategoria
      nombre_etiqueta:$nombre_etiqueta
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarEtiqueta(){
  String query="";
  query=r"""
  mutation modificarEtiqueta(
    $id:ID,
    $nombre_etiqueta:String
  ){
    modificarEtiqueta(
      id:$id
      nombre_etiqueta:$nombre_etiqueta
    )
  }
  """;
  return query;
}
String getMutationEliminarEtiqueta(){
  String query="";
  query=r"""
  mutation eliminarEtiqueta(
    $id:ID,
  ){
    eliminarEtiqueta(
      id:$id
    )
  }
  """;
  return query;
}