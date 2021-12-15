import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';

class Compra{
  String id;
  Sucursal sucursal;
  Proveedor proveedor;
  Usuario usuarioPreCompra;
  Usuario usuarioConfirmacion;
  String nroComprobante;
  String fechaPreCompraMovimiento;
  String fechaPreCompraSistema;
  String fechaConfirmacionMovimiento;
  String fechaConfirmacionSistema;
  double costoTotal;
  bool preCompraTerminada;
  bool confirmado;
  String observacionesPreCompra;
  String observacionesConfirmacion;
  String tipoUsuarioConfirmacion;
  List<CompraProducto> compraProductos;
  Compra({
    required this.id,
    required this.sucursal,
    required this.proveedor,
    required this.usuarioPreCompra,
    required this.usuarioConfirmacion,
    required this.nroComprobante,
    required this.fechaPreCompraMovimiento,
    required this.fechaPreCompraSistema,
    required this.fechaConfirmacionMovimiento,
    required this.fechaConfirmacionSistema,
    required this.costoTotal,
    required this.preCompraTerminada,
    required this.confirmado,
    required this.observacionesPreCompra,
    required this.observacionesConfirmacion,
    required this.tipoUsuarioConfirmacion,
    required this.compraProductos
  });
  int getCantidadProductos(){
    int cantidadProductos=0;
    compraProductos.forEach((cp) { 
      cantidadProductos+=cp.cantidad;
    });
    return cantidadProductos;
  }
  factory Compra.vacio(){
    return Compra(
      id: "", sucursal: Sucursal.vacio(),proveedor: Proveedor.vacio(), usuarioPreCompra: Usuario.vacio(), usuarioConfirmacion: Usuario.vacio(), 
      nroComprobante: "", fechaPreCompraMovimiento: "",fechaPreCompraSistema:"",fechaConfirmacionMovimiento: "", fechaConfirmacionSistema: "",costoTotal: 0.0, preCompraTerminada: false,confirmado: false, 
      observacionesPreCompra: "", observacionesConfirmacion: "",tipoUsuarioConfirmacion: "",compraProductos: []
    );
  }
  factory Compra.fromMap(Map<String,dynamic> data){
    List<CompraProducto> cps=[];
    if(data["compra_productos"]!=null){
      List cpsD=data["compra_productos"];
      cpsD.forEach((data) { 
        cps.add(CompraProducto.fromMap(data));
      });
    }
    
    return Compra(
      id: data["id"]??"", sucursal: data["sucursal"]!=null?Sucursal.fromMap(data["sucursal"]):Sucursal.vacio(), proveedor: data["proveedor"]!=null?Proveedor.fromMap(data["proveedor"]):Proveedor.vacio(), 
      usuarioPreCompra: data["usuario_pre_compra"]!=null?Usuario.fromMap(data["usuario_pre_compra"]):Usuario.vacio(), 
      usuarioConfirmacion: data["usuario_confirmacion"]!=null?Usuario.fromMap(data["usuario_confirmacion"]):Usuario.vacio(), 
      nroComprobante: data["nro_comprobante"]??"", 
      fechaPreCompraMovimiento: data["fecha_pre_compra_movimiento"]??"",fechaPreCompraSistema: data["fecha_pre_compra_sistema"]??"", 
      fechaConfirmacionMovimiento: data["fecha_confirmacion_movimiento"]??"", fechaConfirmacionSistema: data["fecha_confirmacion_sistema"]??"",
      costoTotal: data["costo_total"]!=null?double.parse(data["costo_total"].toString()):0.0, 
      preCompraTerminada: data["pre_compra_terminada"]??false,confirmado: data["confirmado"]??false, observacionesPreCompra: data["observaciones_pre_compra"]??"", 
      observacionesConfirmacion: data["observaciones_confirmacion"]??"",tipoUsuarioConfirmacion: data["tipo_usuario_confirmacion"]??"",compraProductos: cps
    );
  }
  factory Compra.copyWith(Compra c){
    List<CompraProducto> cps=[];
    c.compraProductos.forEach((cp) { 
      cps.add(CompraProducto.copyWith(cp));
    });
    return Compra(
      id: c.id,sucursal: Sucursal.copyWith(c.sucursal), proveedor: Proveedor.copyWith(c.proveedor), usuarioPreCompra: Usuario.copyWith(c.usuarioPreCompra), 
      usuarioConfirmacion: Usuario.copyWith(c.usuarioConfirmacion), nroComprobante: c.nroComprobante, 
      fechaPreCompraMovimiento: c.fechaPreCompraMovimiento, fechaPreCompraSistema: c.fechaPreCompraSistema,
      fechaConfirmacionMovimiento: c.fechaConfirmacionMovimiento, fechaConfirmacionSistema: c.fechaConfirmacionSistema,costoTotal: c.costoTotal, 
      preCompraTerminada: c.preCompraTerminada,confirmado: c.confirmado, observacionesPreCompra: c.observacionesPreCompra, 
      observacionesConfirmacion: c.observacionesConfirmacion,tipoUsuarioConfirmacion: c.tipoUsuarioConfirmacion,compraProductos: cps
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "sucursal":this.sucursal.id,
      "proveedor":this.proveedor.id,
      "usuario_pre_compra":this.usuarioPreCompra.id,
      "usuario_confirmacion":this.usuarioConfirmacion.id,
      "nro_comprobante":this.nroComprobante,
      "fecha_pre_compra_movimiento":this.fechaPreCompraMovimiento,
      "fecha_confirmacion_movimiento":this.fechaConfirmacionMovimiento,
      "costo_total":this.costoTotal,
      "confirmado":this.confirmado,
      "observaciones_pre_compra":this.observacionesPreCompra,
      "observaciones_confirmacion":this.observacionesConfirmacion,
      "tipo_usuario_confirmacion":this.tipoUsuarioConfirmacion
    };
  }
}
class CompraProducto{
  String id;
  Producto producto;
  String lote;
  String fechaVencimiento;
  int cantidad;
  double precioUnitario;
  bool seleccionado=false;
  CompraProducto({
    required this.id,required this.producto,required this.lote,required this.fechaVencimiento,
    required this.cantidad,required this.precioUnitario
  });
  factory CompraProducto.vacio(){
    return CompraProducto(
      id: "", producto: Producto.vacio(), lote: "", fechaVencimiento: "", cantidad: 0, 
      precioUnitario: 0.0
    );
  }
  factory CompraProducto.fromMap(Map<String,dynamic> data){
    return CompraProducto(
      id: data["id"]??"", producto: data["producto"]!=null?Producto.fromMap(data["producto"]):Producto.vacio(), 
      lote: data["lote"]??"", fechaVencimiento: data["fecha_vencimiento"]??"", cantidad: data["cantidad"]??0, 
      precioUnitario: data["precio_unitario"]!=null?double.parse(data["precio_unitario"].toString()):0.0
    );
  }
  factory CompraProducto.copyWith(CompraProducto cp){
    return CompraProducto(
      id: cp.id, producto: cp.producto, lote: cp.lote, fechaVencimiento: cp.fechaVencimiento, 
      cantidad: cp.cantidad, precioUnitario: cp.precioUnitario
    );
  }
  Map<String,dynamic> toMap(){
    return<String,dynamic>{
      "id":this.id,
      "producto":this.producto.id,
      "lote":this.lote,
      "fecha_vencimiento":this.fechaVencimiento,
      "cantidad":this.cantidad,
      "precio_unitario":this.precioUnitario
    };
  }
}