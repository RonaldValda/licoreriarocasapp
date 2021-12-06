
import 'package:licoreriarocasapp/domain/entities/categoria.dart';

class Producto{
  String id;
  String codigo;
  String unidad;
  String contenido;
  double precio;
  int stockMinimo;
  double utilidad;
  int vencimientoMaximo;
  double gradoAlcoholico;
  List<dynamic> imagenesProducto;
  Etiqueta etiqueta;
  Producto({
    required this.id,required this.codigo,required this.unidad,
    required this.contenido,required this.precio,required this.stockMinimo,
    required this.utilidad,required this.vencimientoMaximo,
    required this.gradoAlcoholico,required this.imagenesProducto,
    required this.etiqueta
  });
  factory Producto.vacio(){
    return Producto(
      id: "", codigo:"", unidad: "", contenido: "", precio: 0.0, 
      stockMinimo: 0, utilidad: 0.0, vencimientoMaximo: 0, gradoAlcoholico: 0.0,
      imagenesProducto: [],etiqueta: Etiqueta.vacio()
    );
  }
  factory Producto.fromMap(Map<String,dynamic> data){
    return Producto(
      id: data["id"]??"",codigo: data["codigo"]??"", 
      unidad: data["unidad"]??"", contenido: data["contenido"]??"",
      precio: data["precio"]!=null?double.parse(data["precio"].toString()):0.0, stockMinimo: data["stock_minimo"]??0, 
      utilidad: data["utilidad"]!=null?double.parse(data["utilidad"].toString()):0.0, 
      vencimientoMaximo: data["vencimiento_maximo"]??0, 
      gradoAlcoholico: data["grado_alcoholico"]!=null?double.parse(data["grado_alcoholico"].toString()):0.0,
      imagenesProducto: data["imagenes_producto"]??[],etiqueta: data["etiqueta"]!=null?Etiqueta.fromMap(data["etiqueta"]):Etiqueta.vacio()
    );
  }
  factory Producto.copyWith(Producto p){
    //List<dynamic> imagenes=[];
    //p.imagenesProducto.forEach((element) { });
    return Producto(
      id: p.id,codigo: p.codigo, etiqueta: Etiqueta.copyWith(p.etiqueta), unidad: p.unidad, 
      contenido: p.contenido, precio: p.precio, stockMinimo: p.stockMinimo, 
      utilidad: p.utilidad, vencimientoMaximo: p.vencimientoMaximo, 
      gradoAlcoholico: p.gradoAlcoholico, imagenesProducto: p.imagenesProducto
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "codigo":this.codigo,
      "etiqueta":this.etiqueta,
      "unidad":this.unidad,
      "contenido":this.contenido,
      "precio":this.precio,
      "stock_minimo":this.stockMinimo,
      "utilidad":this.utilidad,
      "vencimiento_maximo":this.vencimientoMaximo,
      "grado_alcoholico":this.gradoAlcoholico,
      "imagenes_producto":this.imagenesProducto
    };
  }
}
class ProductoLote{
  String id;
  String lote;
  String fechaVencimiento;
  int cantidadInicial;
  int cantidadSaldo;
  int cantidadTienda;
  ProductoLote({
    required this.id,required this.lote,
    required this.fechaVencimiento,required this.cantidadInicial,
    required this.cantidadSaldo,required this.cantidadTienda
  });
  factory ProductoLote.vacio(){
    return ProductoLote(
      id: "", lote: "", fechaVencimiento: "", 
      cantidadInicial: 0, cantidadSaldo: 0, cantidadTienda: 0
    );
  }
  factory ProductoLote.fromMap(Map<String,dynamic> data){
    return ProductoLote(
      id: data["id"]??"", lote: data["lote"]??"", 
      fechaVencimiento: data["fecha_vencimiento"]??"", 
      cantidadInicial: data["cantidad_inicial"]??0, 
      cantidadSaldo: data["cantidad_saldo"]??0, 
      cantidadTienda: data["cantidad_tienda"]??0
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "lote":this.lote,
      "fecha_vencimiento":this.fechaVencimiento,
      "cantidad_inicial":this.cantidadInicial,
      "cantidad_saldo":this.cantidadSaldo,
      "cantidad_tienda":this.cantidadTienda
    };
  }
}
class ProductoKardex{
  String id;
  String lote;
  String fecha;
  String detalle;
  String tipo;
  String nroComprobante;
  double valorUnitario;
  int cantidad;
  double valor;
  double cantidadSaldo;
  double valorSaldo;
  ProductoKardex({
    required this.id,required this.lote,required this.fecha,required this.detalle,
    required this.tipo,required this.nroComprobante,required this.valorUnitario,
    required this.cantidad,required this.valor,required this.cantidadSaldo,required this.valorSaldo
  });
  factory ProductoKardex.vacio(){
    return ProductoKardex(
      id: "", lote: "", fecha: "",  detalle: "", tipo: "", nroComprobante: "", 
      valorUnitario: 0.0, cantidad: 0, valor: 0.0, 
      cantidadSaldo: 0, valorSaldo: 0.0
    );
  }
  factory ProductoKardex.fromMap(Map<String,dynamic> data){
    return ProductoKardex(
      id: data["id"]??"", 
      lote: data["lote"]??"", 
      fecha: data["fecha"]??"", 
      detalle: data["detalle"]??"", 
      tipo: data["tipo"]??"", 
      nroComprobante: data["nro_comprobante"]??"", 
      valorUnitario: data["valor_unitario"]??"", 
      cantidad: data["cantidad"]??"", 
      valor: data["valor"]??"", 
      cantidadSaldo: data["cantidad_saldo"]??"", 
      valorSaldo: data["valor_saldo"]
    );
  }
  factory ProductoKardex.copyWith(ProductoKardex pk){
    return ProductoKardex(
      id: pk.id, lote: pk.lote, fecha: pk.fecha, detalle: pk.detalle, tipo: pk.tipo, 
      nroComprobante: pk.nroComprobante, valorUnitario: pk.valorUnitario, cantidad: pk.cantidad, valor: pk.valor, 
      cantidadSaldo: pk.cantidadSaldo, valorSaldo: pk.valorSaldo
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "lote":this.lote,
      "fecha":this.fecha,
      "detalle":this.detalle,
      "tipo":this.tipo,
      "nro_comprobante":this.nroComprobante,
      "valor_unitario":this.valorUnitario,
      "cantidad":this.cantidad,
      "valor":this.valor,
      "cantidad_saldo":this.cantidadSaldo,
      "valor_saldo":this.valorSaldo
    };
  }
}