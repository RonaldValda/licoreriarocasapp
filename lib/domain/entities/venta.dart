
import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';

class Venta{
  String id;
  Sucursal sucursal;
  Cliente cliente;
  Usuario vendedor;
  String nroComprobante;
  String fechaVentaSistema;
  String fechaVentaMovimiento;
  double costoTotal;
  double precioTotal;
  double descuentoTotal;
  List<VentaProducto> ventaProductos;
  Venta({
    required this.id,required this.sucursal,required this.cliente,required this.vendedor,
    required this.nroComprobante,required this.fechaVentaSistema,required this.fechaVentaMovimiento,
    required this.costoTotal,required this.precioTotal,required this.descuentoTotal,
    required this.ventaProductos
  });
  factory Venta.vacio(){
    return Venta(
      id: "", sucursal: Sucursal.vacio(), cliente: Cliente.vacio(), vendedor: Usuario.vacio(), 
      nroComprobante: "",fechaVentaSistema: "", fechaVentaMovimiento: "", costoTotal: 0.0, precioTotal: 0.0, descuentoTotal: 0.0, ventaProductos: []
    );
  }
  factory Venta.fromMap(Map<String,dynamic> data){
    List ventaProductosD=data["venta_productos"]??[];
    List<VentaProducto> vPs=[];
    ventaProductosD.forEach((data) { 
      vPs.add(VentaProducto.fromMap(data));
    });
    return Venta(
      id: data["id"]??"", nroComprobante: data["nro_comprobante"]??"",sucursal: data["sucursal"]!=null?Sucursal.fromMap(data["sucursal"]):Sucursal.vacio(), 
      cliente: data["cliente"]!=null?Cliente.fromMap(data["cliente"]):Cliente.vacio(), 
      vendedor: data["vendedor"]!=null?Usuario.fromMap(data["vendedor"]):Usuario.vacio(), 
      fechaVentaSistema: data["fecha_venta_sistema"]??"", fechaVentaMovimiento: data["fecha_venta_movimiento"]??"", 
      costoTotal: data["costo_total"]!=null?double.parse(data["costo_total"].toString()):0.0, 
      precioTotal: data["precio_total"]!=null?double.parse(data["precio_total"].toString()):0.0, 
      descuentoTotal: data["descuento_total"]!=null?double.parse(data["descuento_total"].toString()):0.0, 
      ventaProductos: vPs
    );
  }
  factory Venta.copyWith(Venta v){
    List<VentaProducto> psVenta=[];
    v.ventaProductos.forEach((vp) { 
      psVenta.add(VentaProducto.copyWith(vp));
    });
    return Venta(
      id: v.id, nroComprobante: v.nroComprobante,sucursal: Sucursal.copyWith(v.sucursal), cliente: Cliente.copyWith(v.cliente), 
      vendedor: Usuario.copyWith(v.vendedor), fechaVentaSistema: v.fechaVentaSistema, 
      fechaVentaMovimiento: v.fechaVentaMovimiento, costoTotal: v.costoTotal, precioTotal: v.precioTotal, 
      descuentoTotal: v.descuentoTotal, ventaProductos: psVenta
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "sucursal":this.sucursal.id,
      "cliente":this.cliente.id,
      "vendedor":this.vendedor.id,
      "nro_comprobante":this.nroComprobante,
      "fecha_venta_movimiento":this.fechaVentaMovimiento,
      "costo_total":this.costoTotal,
      "precio_total":this.precioTotal,
      "descuento_total":this.descuentoTotal
    };
  }
}
class VentaProducto{
  String id;
  Producto producto;
  int cantidad;
  double costoUnitario;
  double precioUnitario;
  bool seleccionado=false;
  VentaProducto({
    required this.id,required this.producto,required this.cantidad,
    required this.costoUnitario,required this.precioUnitario
  });
  factory VentaProducto.vacio(){
    return VentaProducto(
      id: "", producto: Producto.vacio(), cantidad: 0, costoUnitario: 0.0, precioUnitario: 0.0
    );
  }
  factory VentaProducto.fromMap(Map<String,dynamic> data){
    return VentaProducto(
      id: data["id"]??"", producto: data["producto"]!=null?Producto.fromMap(data["producto"]):Producto.vacio(), 
      cantidad: data["cantidad"]??0, costoUnitario: data["costo_unitario"]!=null?double.parse(data["costo_unitario"].toString()):0.0, 
      precioUnitario: data["precio_unitario"]!=null?double.parse(data["precio_unitario"].toString()):0.0
    );
  }
  factory VentaProducto.copyWith(VentaProducto vp){
    return VentaProducto(
      id: vp.id, producto: Producto.copyWith(vp.producto), cantidad: vp.cantidad, 
      costoUnitario: vp.costoUnitario, precioUnitario: vp.precioUnitario
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "producto":this.producto.id,
      "cantidad":this.cantidad,
      "costo_unitario":this.costoUnitario,
      "precio_unitario":this.precioUnitario
    };
  }
}
