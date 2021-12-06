String getMutationRegistrarCompraProducto(){
  String query="";
  query=r"""
  mutation registrarCompraProducto(
    $id_compra:ID,$costo_total:Double,$producto:ID,
    $lote:String,$fecha_vencimiento:String,
    $cantidad:Int,$precio_unitario:Double
  ){
    registrarCompraProducto(
      id_compra:$id_compra,
      costo_total:$costo_total,
      input:{
        producto:$producto
        lote:$lote
        fecha_vencimiento:$fecha_vencimiento
        cantidad:$cantidad
        precio_unitario:$precio_unitario
      }
    ){
      id
    }
  }
  """;
  return query;
}