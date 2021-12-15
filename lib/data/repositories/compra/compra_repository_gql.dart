String getMutationRegistrarPreCompra(){
  String query="";
  query=r"""
  mutation registrarPreCompra(
  	$sucursal:ID,
    $proveedor:ID,$usuario_pre_compra:ID,
    $tipo_usuario_confirmacion:String,
    $nro_comprobante:String,
    $fecha_pre_compra_movimiento:String
    $costo_total:Double
    $observaciones_pre_compra:String,
    $input_compra_productos: [CompraProductoInput!]!
  ){
    registrarPreCompra(
      id_sucursal:$sucursal
      id_proveedor:$proveedor
      id_usuario_pre_compra:$usuario_pre_compra
      tipo_usuario_confirmacion:$tipo_usuario_confirmacion
      input:{
        nro_comprobante:$nro_comprobante
        fecha_pre_compra_movimiento:$fecha_pre_compra_movimiento
        costo_total:$costo_total
        observaciones_pre_compra:$observaciones_pre_compra
      },
      input_compra_productos:$input_compra_productos
    ){
      id
      fecha_pre_compra_movimiento
      fecha_pre_compra_sistema
      compra_productos{
        id
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
String getQueryObtenerPreComprasPendientes(){
  String query="";
  query=r"""
  query obtenerPreComprasPendientes(
    $id_sucursal:String
    $tipo_usuario_confirmacion:String
  ){
    obtenerPreComprasPendientes(
      id_sucursal:$id_sucursal
      tipo_usuario_confirmacion:$tipo_usuario_confirmacion
    ){
      id
      nro_comprobante
      fecha_pre_compra_sistema
      fecha_pre_compra_movimiento
      costo_total
      observaciones_pre_compra
      proveedor{
        id
        ci_nit
        nombres
      }
      usuario_pre_compra{
        id
        link_foto
        tipo_usuario
        nombres
        apellidos
        email
        telefono
      }
      compra_productos{
        id
        lote
        fecha_vencimiento
        cantidad
        precio_unitario
        producto{
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
            nombre_etiqueta
            subcategoria{
              nombre_subcategoria
              categoria{
                nombre_categoria
              }
            }
          }
        }
      }
    }
  }
  """;
  return query;
}
String getMutationResponderConfirmacionPreCompra(){
  String query="";
  query=r"""
  mutation responderConfirmacionPreCompra(
    $usuario_confirmacion:ID,
  	$id:ID,
    $fecha_confirmacion_movimiento:String
    $costo_total:Double
    $confirmado:Boolean
    $observaciones_confirmacion:String,
    $input_compra_productos: [CompraProductoInput!]!
  ){
    responderConfirmacionPreCompra(
      id_usuario_confirmacion:$usuario_confirmacion
      id_compra:$id
      input:{
        fecha_confirmacion_movimiento:$fecha_confirmacion_movimiento
        costo_total:$costo_total
        confirmado:$confirmado
        observaciones_confirmacion:$observaciones_confirmacion
      },
      input_compra_productos:$input_compra_productos
    ){
      fecha_confirmacion_movimiento
      fecha_confirmacion_sistema
    }
  }
  """;
  return query;
}