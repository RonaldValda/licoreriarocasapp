class ConfiguracionEmpresa{
  String id;
  String monedaPrincipal;
  String monedaSecundaria;
  double cambioMonedaSecundariaPrincipal;
  double utilidadMinimaGeneral;
  double tazaAdicionalGeneral;
  bool ordenarCategoriasAlfabeticamente;
  bool ordenarSubcategoriasAlfabeticamente;
  bool ordenarEtiquetasAlfabeticamente;
  double montoMaximoVariacionCaja;
  String fechaInicio;
  String fechaFinal;
  bool estado;
  ConfiguracionEmpresa({
    required this.id,
    required this.monedaPrincipal,
    required this.monedaSecundaria,
    required this.cambioMonedaSecundariaPrincipal,
    required this.utilidadMinimaGeneral,
    required this.tazaAdicionalGeneral,
    required this.ordenarCategoriasAlfabeticamente,
    required this.ordenarSubcategoriasAlfabeticamente,
    required this.ordenarEtiquetasAlfabeticamente,
    required this.montoMaximoVariacionCaja,
    required this.fechaInicio,
    required this.fechaFinal,
    required this.estado
  });
  factory ConfiguracionEmpresa.vacio(){
    return ConfiguracionEmpresa(
      id: "", monedaPrincipal: "", monedaSecundaria: "", 
      cambioMonedaSecundariaPrincipal: 0.0, utilidadMinimaGeneral: 0.0, 
      tazaAdicionalGeneral: 0.0, ordenarCategoriasAlfabeticamente: false, 
      ordenarSubcategoriasAlfabeticamente: false, ordenarEtiquetasAlfabeticamente: false, 
      montoMaximoVariacionCaja: 0.0,fechaInicio:"",fechaFinal:"",estado:false
    );
  }
  factory ConfiguracionEmpresa.fromMap(Map<String,dynamic> data){
    return ConfiguracionEmpresa(
      id: data["id"]??"", 
      monedaPrincipal: data["moneda_principal"]??"", 
      monedaSecundaria: data["moneda_secundaria"]??"", 
      cambioMonedaSecundariaPrincipal: data["cambio_moneda_secundaria_principal"]!=null?double.parse(data["cambio_moneda_secundaria_principal"].toString()):0.0, 
      utilidadMinimaGeneral: data["utilidad_minima_general"]!=null?double.parse(data["utilidad_minima_general"].toString()):0.0, 
      tazaAdicionalGeneral: data["taza_adicional_general"]!=null?double.parse(data["taza_adicional_general"].toString()):0.0, 
      ordenarCategoriasAlfabeticamente: data["ordenar_categorias_alfabeticamente"]??false, 
      ordenarSubcategoriasAlfabeticamente: data["ordenar_subcategorias_alfabeticamente"]??false, 
      ordenarEtiquetasAlfabeticamente: data["ordenar_etiquetas_alfabeticamente"]??false, 
      montoMaximoVariacionCaja: data["monto_maximo_variacion_caja"]!=null?double.parse(data["monto_maximo_variacion_caja"].toString()):0.0,
      fechaInicio: data["fecha_inicio"]??"",fechaFinal: data["fecha_final"]??"",
      estado: data["estado"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return<String,dynamic>{
      "id":this.id,
      "moneda_principal":this.monedaPrincipal,
      "moneda_secundaria":this.monedaSecundaria,
      "cambio_moneda_secundaria_principal":this.cambioMonedaSecundariaPrincipal,
      "utilidad_minima_general":this.utilidadMinimaGeneral,
      "taza_adicional_general":this.tazaAdicionalGeneral,
      "ordenar_categorias_alfabeticamente":this.ordenarCategoriasAlfabeticamente,
      "ordenar_subcategorias_alfabeticamente":this.ordenarSubcategoriasAlfabeticamente,
      "ordenar_etiquetas_alfabeticamente":this.ordenarEtiquetasAlfabeticamente,
      "monto_maximo_variacion_caja":this.montoMaximoVariacionCaja,
      "estado":this.estado
    };
  }
  factory ConfiguracionEmpresa.copyWith(ConfiguracionEmpresa ce){
    return ConfiguracionEmpresa(
      id: ce.id, monedaPrincipal: ce.monedaPrincipal, monedaSecundaria: ce.monedaSecundaria, 
      cambioMonedaSecundariaPrincipal: ce.cambioMonedaSecundariaPrincipal, 
      utilidadMinimaGeneral: ce.utilidadMinimaGeneral, tazaAdicionalGeneral: ce.tazaAdicionalGeneral, 
      ordenarCategoriasAlfabeticamente: ce.ordenarCategoriasAlfabeticamente, 
      ordenarSubcategoriasAlfabeticamente: ce.ordenarSubcategoriasAlfabeticamente, 
      ordenarEtiquetasAlfabeticamente: ce.ordenarEtiquetasAlfabeticamente, 
      montoMaximoVariacionCaja: ce.montoMaximoVariacionCaja, 
      fechaInicio: ce.fechaInicio, fechaFinal: ce.fechaFinal, estado: ce.estado
    );
  }
}