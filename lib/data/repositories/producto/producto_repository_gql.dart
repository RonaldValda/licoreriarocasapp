String getMutationRegistrarProducto(){
  String query="";
  query=r"""
  mutation registrarProducto(
    $codigo:String,$unidad:String,$contenido:String,
    $precio:Double,$grado_alcoholico:Double,
    $vencimiento_maximo:Int,$stock_minimo:Int,
    $utilidad:Double,
    $imagenes_producto:[String],
    $id_etiqueta:ID
  ){
    registrarProducto(
      input:{
        codigo:$codigo
        unidad:$unidad
        contenido:$contenido
        precio:$precio
        grado_alcoholico:$grado_alcoholico
        vencimiento_maximo:$vencimiento_maximo
        stock_minimo:$stock_minimo
        utilidad:$utilidad
        imagenes_producto:$imagenes_producto
        etiqueta:$id_etiqueta
      }
    ){
      id
    }
  }
  """;
  return query;
}
String getMutationModificarProducto(){
  String query="";
  query=r"""
  mutation modificarProducto(
    $id:ID,
    $codigo:String,$unidad:String,$contenido:String,
    $precio:Double,$grado_alcoholico:Double,
    $vencimiento_maximo:Int,$stock_minimo:Int,
    $utilidad:Double,
    $imagenes_producto:[String],
    $id_etiqueta:ID
  ){
    modificarProducto(
      id:$id
      input:{
        codigo:$codigo
        unidad:$unidad
        contenido:$contenido
        precio:$precio
        grado_alcoholico:$grado_alcoholico
        vencimiento_maximo:$vencimiento_maximo
        stock_minimo:$stock_minimo
        utilidad:$utilidad
        imagenes_producto:$imagenes_producto
        etiqueta:$id_etiqueta
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarProducto(){
  String query="";
  query=r"""
  mutation eliminarProducto(
    $id:ID
  ){
    eliminarProducto(
      id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerProductos(){
  String query="";
  query=r"""
  query obtenerProductos(
    $id_etiqueta:ID
  ){
    obtenerProductos(
      id_etiqueta:$id_etiqueta
    ){
      id
      codigo
      unidad
      contenido
      precio
      grado_alcoholico
      vencimiento_maximo
      stock_minimo
      imagenes_producto
      utilidad
      cantidad_favoritos
      fecha_registro
    }
  }
  """;
  return query;
}
String getQueryObtenerProductosGeneral(){
  String query="";
  query=r"""
  query obtenerProductosGeneral{
    obtenerProductosGeneral{
      id
      codigo
      unidad
      contenido
      precio
      grado_alcoholico
      vencimiento_maximo
      stock_minimo
      imagenes_producto
      utilidad
    }
  }
  """;
  return query;
}
String getQueryBuscarProductoContenido(){
  String query="";
  query=r"""
  query buscarProductoContenido(
    $contenido:String
  ){
    buscarProductoContenido(
      contenido:$contenido
    ){
      id
      codigo
      unidad
      contenido
      precio
      grado_alcoholico
      vencimiento_maximo
      stock_minimo
      utilidad
      imagenes_producto
      etiqueta{
        id
        nombre_etiqueta
        subcategoria{
          id
          nombre_subcategoria
          categoria{
            id
            nombre_categoria
          }
        }
      }
    }
  }
  """;
  return query;
}