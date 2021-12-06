String getMutationRegistrarPreCompra(){
  String query="";
  query=r"""
  mutation registrarPreCompra(
    $proveedor:ID,$usuario_pre_compra:ID,
    $tipo_usuario_confirmacion:String,
    $nro_comprobante:String,
    $observaciones_pre_compra:String,
    $input_compra_productos: [CompraProductoInput!]!
  ){
    registrarPreCompra(
      id_proveedor:$proveedor
      id_usuario_pre_compra:$usuario_pre_compra
      tipo_usuario_confirmacion:$tipo_usuario_confirmacion
      input:{
        nro_comprobante:$nro_comprobante
        observaciones_pre_compra:$observaciones_pre_compra
      },
      input_compra_productos:$input_compra_productos
    ){
      id
      producto{
        id
      }
      compra{
        id
        fecha_pre_compra
      }
    }
  }
  """;
  return query;
}
String getMutationModificarPreCompra(){
  String query="";
  query=r"""
  mutation modificarPreCompra(
    $id:ID,$id_proveedor:ID,$nro_comprobante:String,
    $observaciones_pre_compra:String
  ){
    modificarPreCompra(
      id:$id
      id_proveedor:$id_proveedor
      input:{
        nro_comprobante:$nro_comprobante
        observaciones_pre_compra:$observaciones_pre_compra
      }
    )
  }
  """;
  return query;
}
String getMutationTerminarPreCompra(){
  String query="";
  query=r"""
  mutation terminarPreCompra(
    $id:ID,$observaciones_pre_compra:String
  ){
    terminarPreCompra(
      id:$id
      observaciones_pre_compra:$observaciones_pre_compra
    )
  }
  """;
  return query;
}