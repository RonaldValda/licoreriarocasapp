String getMutationRegistrarCategoria(){
  String query="";
  query=r"""
  mutation registrarCategoria(
    $nombre_categoria:String
  ){
    registrarCategoria(
      nombre_categoria:$nombre_categoria
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarCategoria(){
  String query="";
  query=r"""
  mutation modificarCategoria(
    $id:ID
    $nombre_categoria:String
  ){
    modificarCategoria(
      id:$id
      nombre_categoria:$nombre_categoria
    )
  }
  """;
  return query;
}
String getMutationEliminarCategoria(){
  String query="";
  query=r"""
  mutation eliminarCategoria(
    $id:ID
  ){
    eliminarCategoria(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerCategorias(){
  String query="";
  query=r"""
    query obtenerCategorias{
      obtenerCategorias{
        id
        nombre_categoria
        subcategorias{
          id
          nombre_subcategoria
          etiquetas{
            id
            nombre_etiqueta
          }
        }
      }
    }
  """;
  return query;
}
String getMutationRegistrarMuchasCategorias(){
  String query="";
  query=r"""
  mutation (
    $input:[CategoriaInput!]!
  ){
    registrarMuchasCategorias(
      input:$input
      
    )
  }
  """;
  return query;
}