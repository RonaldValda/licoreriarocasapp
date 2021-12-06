String getMutationRegistrarSucursalAlmacen(){
  String query="";
  query=r"""
  mutation registrarSucursalAlmacen(
    $id_sucursal:ID
    $localizacion:String
  ){
    registrarSucursalAlmacen(
      id_sucursal:$id_sucursal
      localizacion:$localizacion
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarSucursalAlmacen(){
  String query="";
  query=r"""
  mutation modificarSucursalAlmacen(
    $id:ID
    $localizacion:String
  ){
    modificarSucursalAlmacen(
      id:$id
      localizacion:$localizacion
    )
  }
  """;
  return query;
}
String getMutationEliminarSucursalAlmacen(){
  String query="";
  query=r"""
  mutation eliminarSucursalAlmacen(
    $id:ID
  ){
    eliminarSucursalAlmacen(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerSucursalAlmacenes(){
  String query="";
  query=r"""
  query obtenerSucursalAlmacenes(
    $id_sucursal:ID
  ){
    obtenerSucursalAlmacenes(
      id_sucursal:$id_sucursal
    ){
      id
      localizacion
    }
  }
  """;
  return query;
}