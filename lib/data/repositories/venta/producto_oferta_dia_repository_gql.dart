String getMutationRegistrarProductoOfertaDia(){
  String query="";
  query=r"""
  mutation registrarProductoOfertaDia(
    $producto:ID,$fecha:Date,$activo:Boolean,
    $solo_tienda:Boolean,$solo_app:Boolean,
    $tienda_app:Boolean,$precio_unitario:Double
  ){
    registrarProductoOfertaDia(
      input:{
        producto:$producto
        fecha:$fecha
        activo:$activo
        solo_tienda:$solo_tienda
        solo_app:$solo_app
        tienda_app:$tienda_app
        precio_unitario:$precio_unitario
      }
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarProductoOfertaDia(){
  String query="";
  query=r"""
  mutation modificarProductoOfertaDia(
    $id:ID,
  	$producto:ID,$fecha:Date,$activo:Boolean,
    $solo_tienda:Boolean,$solo_app:Boolean,
    $tienda_app:Boolean,$precio_unitario:Double
  ){
    modificarProductoOfertaDia(
      id:$id
      input:{
        producto:$producto
        fecha:$fecha
        activo:$activo
        solo_tienda:$solo_tienda
        solo_app:$solo_app
        tienda_app:$tienda_app
        precio_unitario:$precio_unitario
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarProductoOfertaDia(){
  String query="";
  query=r"""
  mutation eliminarProductoOfertaDia(
    $id:ID
  ){
    eliminarProductoOfertaDia(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerProductoOfertaDia(){
  String query="";
  query=r"""
  query obtenerProductoOfertaDia(
    $producto:ID,$fecha:Date
  ){
    obtenerProductoOfertaDia(
      producto:$producto
      fecha:$fecha
    ){
      id
      fecha
      activo
      solo_tienda
      solo_app
      tienda_app
      precio_unitario
      producto{
        id
        codigo
        unidad
        contenido
        precio
      }
    }
  }
  """;
  return query;
}