String getMutationRegistrarUsuario(){
  String query="";
  query=r"""
  mutation registrarUsuario(
    $link_foto:String,$nombres:String,$apellidos:String,
    $email:String,$password:String,$medio_registro:String,
    $tipo_usuario:String,$imei_telefono:String,$telefono:String,$estado_cuenta:Boolean
  ){
    registrarUsuario(
      input:{
        link_foto:$link_foto
        nombres:$nombres
        apellidos:$apellidos
        email:$email
        password:$password
        medio_registro:$medio_registro
        tipo_usuario:$tipo_usuario
        imei_telefono:$imei_telefono
        telefono:$telefono
        estado_cuenta:$estado_cuenta
      }
    ){
      id
      fecha_registro
    }
  }
  """;
  return query;
}
String getMutationModificarUsuario(){
  String query="";
  query=r"""
  mutation modificarUsuario(
    $id:ID,
    $link_foto:String,$nombres:String,$apellidos:String,
    $email:String,$password:String,$medio_registro:String,
    $tipo_usuario:String,$imei_telefono:String,$telefono:String,$estado_cuenta:Boolean
  ){
    modificarUsuario(
      id:$id
      input:{
        link_foto:$link_foto
        nombres:$nombres
        apellidos:$apellidos
        email:$email
        password:$password
        medio_registro:$medio_registro
        tipo_usuario:$tipo_usuario
        imei_telefono:$imei_telefono
        telefono:$telefono
        estado_cuenta:$estado_cuenta
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarUsuario(){
  String query="";
  query=r"""
  mutation eliminarUsuario(
    $id:ID
  ){
    eliminarUsuario(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerUsuarios(){
  String query="";
  query=r"""
  query obtenerUsuarios{
  obtenerUsuarios{
    id
    link_foto
    nombres
    apellidos
    email
    imei_telefono
    medio_registro
    fecha_registro
    tipo_usuario
    telefono
    estado_cuenta
  }
}
  """;
  return query;
}
String getMutationAutenticarUsuario(){
  String query="";
  query=r"""
  mutation autenticarUsuario(
    $email:String,$password:String,$medio_registro:String
  ){
    autenticarUsuario(
      email:$email
      password:$password
      medio_registro:$medio_registro
    ){
      id
      link_foto
      nombres
      fecha_registro
      fecha_ultimo_ingreso
      fecha_penultimo_ingreso
      tipo_usuario
      telefono
      estado_cuenta
    }
  }
  """;
  return query;
}