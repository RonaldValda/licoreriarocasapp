
import 'package:licoreriarocasapp/domain/entities/categoria.dart';
import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';

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
  List<ProductoLote> productoLotes;
  int cantidadFavoritos;
  List<ClienteFavorito> clientesFavorito;
  String fechaRegistro;
  Etiqueta etiqueta;
  Producto({
    required this.id,required this.codigo,required this.unidad,
    required this.contenido,required this.precio,required this.stockMinimo,
    required this.utilidad,required this.vencimientoMaximo,
    required this.gradoAlcoholico,required this.imagenesProducto,
    required this.etiqueta,required this.productoLotes,
    required this.cantidadFavoritos,required this.clientesFavorito,
    required this.fechaRegistro
  });
  factory Producto.vacio(){
    return Producto(
      id: "", codigo:"", unidad: "", contenido: "", precio: 0.0, 
      stockMinimo: 0, utilidad: 0.0, vencimientoMaximo: 0, gradoAlcoholico: 0.0,
      imagenesProducto: [],etiqueta: Etiqueta.vacio(),productoLotes: [],
      cantidadFavoritos: 0,clientesFavorito: [],fechaRegistro: ""
    );
  }
  factory Producto.fromMap(Map<String,dynamic> data){
    List productoLotesD=data["producto_lotes"]??[];
    List<ProductoLote> psLote=[];
    productoLotesD.forEach((data) { 
      psLote.add(ProductoLote.fromMap(data));
    });
    List clientesFavoritosD=data["clientes_favoritos"]??[];
    List<ClienteFavorito> cfs=[];
    clientesFavoritosD.forEach((data) { 
      cfs.add(ClienteFavorito.fromMap(data));
    });
    return Producto(
      id: data["id"]??"",codigo: data["codigo"]??"", 
      unidad: data["unidad"]??"", contenido: data["contenido"]??"",
      precio: data["precio"]!=null?double.parse(data["precio"].toString()):0.0, stockMinimo: data["stock_minimo"]??0, 
      utilidad: data["utilidad"]!=null?double.parse(data["utilidad"].toString()):0.0, 
      vencimientoMaximo: data["vencimiento_maximo"]??0, 
      gradoAlcoholico: data["grado_alcoholico"]!=null?double.parse(data["grado_alcoholico"].toString()):0.0,
      imagenesProducto: data["imagenes_producto"]??[],etiqueta: data["etiqueta"]!=null?Etiqueta.fromMap(data["etiqueta"]):Etiqueta.vacio(),
      productoLotes: psLote,cantidadFavoritos: data["cantidad_favoritos"]??0,clientesFavorito: cfs,fechaRegistro: data["fecha_registro"]??""
    );
  }
  factory Producto.copyWith(Producto p){
    List<ProductoLote> psLote=[];
    p.productoLotes.forEach((pl) { 
      psLote.add(ProductoLote.copyWith(pl));
    });
    List<ClienteFavorito> cfs=[];
    p.clientesFavorito.forEach((cf) { 
      cfs.add(ClienteFavorito.copyWith(cf));
    });
    return Producto(
      id: p.id,codigo: p.codigo, etiqueta: Etiqueta.copyWith(p.etiqueta), unidad: p.unidad, 
      contenido: p.contenido, precio: p.precio, stockMinimo: p.stockMinimo, 
      utilidad: p.utilidad, vencimientoMaximo: p.vencimientoMaximo, 
      gradoAlcoholico: p.gradoAlcoholico, imagenesProducto: p.imagenesProducto,
      productoLotes: psLote,cantidadFavoritos: p.cantidadFavoritos,clientesFavorito: cfs,
      fechaRegistro: p.fechaRegistro
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
  Sucursal sucursal;
  String lote;
  String fechaVencimiento;
  int cantidadInicial;
  int cantidadSaldo;
  Producto producto;
  ProductoLote({
    required this.id,required this.sucursal,required this.lote,
    required this.fechaVencimiento,required this.cantidadInicial,
    required this.cantidadSaldo,required this.producto
  });
  factory ProductoLote.vacio(){
    return ProductoLote(
      id: "", sucursal: Sucursal.vacio(),lote: "", fechaVencimiento: "", 
      cantidadInicial: 0, cantidadSaldo: 0,
      producto: Producto.vacio()
    );
  }
  factory ProductoLote.fromMap(Map<String,dynamic> data){
    return ProductoLote(
      id: data["id"]??"", sucursal: data["sucursal"]!=null?Sucursal.fromMap(data["sucursal"]):Sucursal.vacio(),
      lote: data["lote"]??"", fechaVencimiento: data["fecha_vencimiento"]??"", 
      cantidadInicial: data["cantidad_inicial"]??0,
      cantidadSaldo: data["cantidad_saldo"]??0,
      producto: data["producto"]!=null?Producto.fromMap(data["producto"]):Producto.vacio()
    );
  }
  factory ProductoLote.copyWith(ProductoLote pl){
    return ProductoLote(
      id: pl.id, sucursal: Sucursal.vacio(),lote: pl.lote, fechaVencimiento: pl.fechaVencimiento, cantidadInicial: pl.cantidadInicial, 
      cantidadSaldo: pl.cantidadSaldo, producto: pl.producto
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "lote":this.lote,
      "fecha_vencimiento":this.fechaVencimiento,
      "cantidad_inicial":this.cantidadInicial,
      "cantidad_saldo":this.cantidadSaldo
    };
  }
}
class ProductoKardex{
  String id;
  String fecha;
  String detalle;
  String tipo;
  String nroComprobante;
  double valorUnitario;
  int cantidad;
  double valor;
  int cantidadSaldo;
  double valorSaldo;
  ProductoKardex({
    required this.id,required this.fecha,required this.detalle,
    required this.tipo,required this.nroComprobante,required this.valorUnitario,
    required this.cantidad,required this.valor,required this.cantidadSaldo,required this.valorSaldo
  });
  factory ProductoKardex.vacio(){
    return ProductoKardex(
      id: "", fecha: "",  detalle: "", tipo: "", nroComprobante: "", 
      valorUnitario: 0.0, cantidad: 0, valor: 0.0, 
      cantidadSaldo: 0, valorSaldo: 0.0
    );
  }
  factory ProductoKardex.fromMap(Map<String,dynamic> data){
    return ProductoKardex(
      id: data["id"]??"",  
      fecha: data["fecha"]??"", 
      detalle: data["detalle"]??"", 
      tipo: data["tipo"]??"", 
      nroComprobante: data["nro_comprobante"]??"", 
      valorUnitario: data["valor_unitario"]!=null?double.parse(data["valor_unitario"].toString()):0.0, 
      cantidad: data["cantidad"]??0, 
      valor: data["valor"]!=null?double.parse(data["valor"].toString()):0.0, 
      cantidadSaldo: data["cantidad_saldo"]??0, 
      valorSaldo: data["valor_saldo"]!=null?double.parse(data["valor_saldo"].toString()):0.0
    );
  }
  factory ProductoKardex.copyWith(ProductoKardex pk){
    return ProductoKardex(
      id: pk.id, fecha: pk.fecha, detalle: pk.detalle, tipo: pk.tipo, 
      nroComprobante: pk.nroComprobante, valorUnitario: pk.valorUnitario, cantidad: pk.cantidad, valor: pk.valor, 
      cantidadSaldo: pk.cantidadSaldo, valorSaldo: pk.valorSaldo
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
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
