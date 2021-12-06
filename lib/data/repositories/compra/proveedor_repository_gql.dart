String getMutationRegistrarProveedor(){
  String query="";
  query=r"""
  mutation registrarProveedor(
    $ci_nit:String,$nombres:String,$estado:Boolean
  ){
    registrarProveedor(
      input:{
        ci_nit:$ci_nit
        nombres:$nombres
        estado:$estado
      }
    ){
      id
      fecha_registro
    }
  }
  """;
  return query;
}
String getMutationModificarProveedor(){
  String query="";
  query=r"""
  mutation modificarProveedor(
    $id:ID,$ci_nit:String,$nombres:String,$estado:Boolean
  ){
    modificarProveedor(
      id:$id
      input:{
        ci_nit:$ci_nit
        nombres:$nombres
        estado:$estado
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarProveedor(){
  String query="";
  query=r"""
    mutation eliminarProveedor(
    $id:ID
  ){
    eliminarProveedor(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerProveedores(){
  String query="";
  query=r"""
  query obtenerProveedores{
    obtenerProveedores{
      id
      ci_nit
      nombres
      fecha_registro
      estado
    }
  }
  """;
  return query;
}
String getQueryBuscarProveedor(){
  String query="";
  query=r"""
  query buscarProveedor(
    $ci_nit:String,$nombres:String
  ){
    buscarProveedor(
      ci_nit:$ci_nit
      nombres:$nombres
    ){
      id
      ci_nit
      nombres
      fecha_registro
      estado
    }
  }
  """;
  return query;
}