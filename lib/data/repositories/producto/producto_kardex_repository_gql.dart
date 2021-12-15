String getMutationRegistrarProductoKardex(){
  String query="";
  return query;
}
String getMutationModificarProductoKardex(){
  String query="";
  return query;
}
String getMutationEliminarProductoKardex(){
  String query="";
  return query;
}
String getQueryObtenerProductoKardexs(){
  String query="";
  query=r"""
  query obtenerProductoKardexs(
    $id_sucursal:ID,$id_producto:ID,
    $fecha_inicial:Date,$fecha_final:Date
  ){
    obtenerProductoKardexs(
      id_sucursal:$id_sucursal
      id_producto:$id_producto
      fecha_inicial:$fecha_inicial
      fecha_final:$fecha_final
    ){
      id
      fecha
      detalle
      tipo
      nro_comprobante
      valor_unitario
      cantidad
      valor
      cantidad_saldo
      valor_saldo
      usuario{
        id
        link_foto
        nombres
        apellidos
        email
        tipo_usuario
      }
    }
  }
  """;
  return query;
}