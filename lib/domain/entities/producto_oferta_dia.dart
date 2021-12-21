import 'package:licoreriarocasapp/domain/entities/producto.dart';

class ProductoOfertaDia{
  String id;
  Producto producto;
  String fecha;
  bool activo;
  bool soloApp;
  bool soloTienda;
  bool tiendaApp;
  double precioUnitario;
  ProductoOfertaDia({
    required this.id,required this.producto,required this.fecha,required this.activo,
    required this.soloApp,required this.soloTienda,required this.tiendaApp,required this.precioUnitario
  });
  factory ProductoOfertaDia.vacio(){
    return ProductoOfertaDia(
      id: "", producto: Producto.vacio(), fecha: "", activo: false, 
      soloApp: false, soloTienda: false, tiendaApp: false,precioUnitario: 0
    );
  }
  factory ProductoOfertaDia.fromMap(Map<String,dynamic> data){
    return ProductoOfertaDia(
      id: data["id"]??"", producto: data["producto"]!=null?Producto.fromMap(data["producto"]):Producto.vacio(), 
      fecha: data["fecha"]??"", activo: data["activo"], soloApp: data["solo_app"]??false, 
      soloTienda: data["solo_tienda"]??false, tiendaApp: data["tienda_app"]??false, 
      precioUnitario: data["precio_unitario"]!=null?double.parse(data["precio_unitario"].toString()):0.0
    );
  }
  factory ProductoOfertaDia.copyWith(ProductoOfertaDia p){
    return ProductoOfertaDia(
      id: p.id, producto: Producto.copyWith(p.producto), fecha: p.fecha, activo: p.activo, 
      soloApp: p.soloApp, soloTienda: p.soloTienda, tiendaApp: p.tiendaApp, precioUnitario: p.precioUnitario
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "producto":this.producto.id,
      "fecha":this.fecha,
      "activo":this.activo,
      "solo_app":this.soloApp,
      "solo_tienda":this.soloTienda,
      "tienda_app":this.tiendaApp,
      "precio_unitario":this.precioUnitario
    };
  }
}