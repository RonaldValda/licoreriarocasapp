String getMutationRegistrarSucursal(){
  String query="";
  query=r"""
  mutation registrarSucursal(
    $descripcion:String,$direccion:String,$telefonos:[String],
    $estado:Boolean,$coordenadas:[Double]
  ){
    registrarSucursal(
      input:{
        descripcion:$descripcion
        direccion:$direccion
        telefonos:$telefonos
        estado:$estado
        coordenadas:$coordenadas
      }
    ){
      id
      fecha_registro
    }
  }
  """;
  return query;
}
String getMutationModificarSucursal(){
  String query="";
  query=r"""
  mutation modificarSucursal(
    $id:ID,
    $descripcion:String,$direccion:String,$telefonos:[String],
    $estado:Boolean,$coordenadas:[Double]
  ){
    modificarSucursal(
      id:$id
      input:{
        descripcion:$descripcion
        direccion:$direccion
        telefonos:$telefonos
        estado:$estado
        coordenadas:$coordenadas
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarSucursal(){
  String query="";
  query=r"""
  mutation eliminarSucursal(
    $id:ID
  ){
    eliminarSucursal(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerSucursales(){
  String query="";
  query=r"""
  query obtenerSucursales{
    obtenerSucursales{
      id
      descripcion
      direccion
      telefonos
      fecha_registro
      estado
      coordenadas
    }
  }
  """;
  return query;
}