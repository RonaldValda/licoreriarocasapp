String getMutationRegistrarConfiguracionEmpresa(){
  String query="";
  query=r"""
  mutation registrarConfiguracionEmpresa(
    $moneda_principal:String,$moneda_secundaria:String,
    $cambio_moneda_secundaria_principal:Double,
    $utilidad_minima_general:Double,
    $taza_adicional_general:Double,
    $ordenar_categorias_alfabeticamente:Boolean,
    $ordenar_subcategorias_alfabeticamente:Boolean,
    $ordenar_etiquetas_alfabeticamente:Boolean,
    $monto_maximo_variacion_caja:Double,
  	$estado:Boolean
  ){
    registrarConfiguracionEmpresa(
      input:{
        moneda_principal:$moneda_principal
        moneda_secundaria:$moneda_secundaria
        cambio_moneda_secundaria_principal:$cambio_moneda_secundaria_principal
        utilidad_minima_general:$utilidad_minima_general
        taza_adicional_general:$taza_adicional_general
        ordenar_categorias_alfabeticamente:$ordenar_categorias_alfabeticamente
        ordenar_subcategorias_alfabeticamente:$ordenar_subcategorias_alfabeticamente
        ordenar_etiquetas_alfabeticamente:$ordenar_etiquetas_alfabeticamente
        monto_maximo_variacion_caja:$monto_maximo_variacion_caja
      	estado:$estado
      }
    ){
      id
      fecha_inicio
      fecha_final
    }
  }
  """;
  return query;
}
String getMutationModificarConfiguracionEmpresa(){
  String query="";
  query=r"""
  mutation modificarConfiguracionEmpresa(
 		$id:ID, 
    $moneda_principal:String,$moneda_secundaria:String,
    $cambio_moneda_secundaria_principal:Double,
    $utilidad_minima_general:Double,
    $taza_adicional_general:Double,
    $ordenar_categorias_alfabeticamente:Boolean,
    $ordenar_subcategorias_alfabeticamente:Boolean,
    $ordenar_etiquetas_alfabeticamente:Boolean,
    $monto_maximo_variacion_caja:Double,
  	$estado:Boolean
  ){
    modificarConfiguracionEmpresa(
 			id:$id
      input:{
        moneda_principal:$moneda_principal
        moneda_secundaria:$moneda_secundaria
        cambio_moneda_secundaria_principal:$cambio_moneda_secundaria_principal
        utilidad_minima_general:$utilidad_minima_general
        taza_adicional_general:$taza_adicional_general
        ordenar_categorias_alfabeticamente:$ordenar_categorias_alfabeticamente
        ordenar_subcategorias_alfabeticamente:$ordenar_subcategorias_alfabeticamente
        ordenar_etiquetas_alfabeticamente:$ordenar_etiquetas_alfabeticamente
        monto_maximo_variacion_caja:$monto_maximo_variacion_caja
      	estado:$estado
      }
    )
  }
  """;
  return query;
}
String getMutationEliminarConfiguracionEmpresa(){
  String query="";
  query=r"""
  mutation eliminarConfiguracionEmpresa(
 		$id:ID
  ){
    eliminarConfiguracionEmpresa(
 			id:$id
    )
  }
  """;
  return query;
}
String getQueryObtenerConfiguracionesEmpresa(){
  String query="";
  query=r"""
  query obtenerConfiguracionesEmpresa{
    obtenerConfiguracionesEmpresa{
      id
      moneda_principal
      moneda_secundaria
      cambio_moneda_secundaria_principal
      utilidad_minima_general
      taza_adicional_general
      ordenar_categorias_alfabeticamente
      ordenar_subcategorias_alfabeticamente
      ordenar_etiquetas_alfabeticamente
      monto_maximo_variacion_caja
      fecha_inicio
      fecha_final
      estado
    }
  }
  """;
  return query;
}