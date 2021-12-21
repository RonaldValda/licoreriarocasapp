String getMutationRegistrarCliente(){
  String query="";
  query=r"""
  mutation registrarCliente(
    $ci_nit:String,$nombres:String,$fecha_nacimiento:String,
    $email:String,$telefono:String
  ){
    registrarCliente(
      input:{
        ci_nit:$ci_nit
        nombres:$nombres
        fecha_nacimiento:$fecha_nacimiento
        email:$email
        telefono:$telefono
      }
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarCliente(){
  String query="";
  query=r"""
  mutation modificarCliente(
    $id:ID,
    $ci_nit:String,$nombres:String,$fecha_nacimiento:String,
    $email:String,$telefono:String
  ){
    modificarCliente(
      id:$id
      input:{
        ci_nit:$ci_nit
        nombres:$nombres
        fecha_nacimiento:$fecha_nacimiento
        email:$email
        telefono:$telefono
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarCliente(){
  String query="";
  query=r"""
  mutation eliminarCliente(
    $id:ID
  ){
    eliminarCliente(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerClientes(){
  String query="";
  query=r"""
  query obtenerClientes{
    obtenerClientes{
      id
      ci_nit
      nombres
      fecha_nacimiento
      email
      telefono
    }
  }
  """;
  return query;
}
String getQueryBuscarCliente(){
  String query="";
  query=r"""
  query buscarCliente(
    $ci_nit:String,$nombres:String
  ){
    buscarCliente(
      ci_nit:$ci_nit
      nombres:$nombres
    ){
      id
      ci_nit
      nombres
      fecha_nacimiento
      email
      telefono
    }
  }
  """;
  return query;
}