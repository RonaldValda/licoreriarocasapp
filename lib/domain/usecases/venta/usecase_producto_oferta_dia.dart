import 'package:licoreriarocasapp/data/repositories/venta/producto_oferta_dia_repository.dart';
import 'package:licoreriarocasapp/domain/entities/producto_oferta_dia.dart';

class UseCaseProductoOfertaDia{
  ProductoOfertaDiaRepository productoOfertaDiaRepository=ProductoOfertaDiaRepository();
  Future<Map<String,dynamic>> registrarProductoOfertaDia(ProductoOfertaDia productoOfertaDia){
    return productoOfertaDiaRepository.registrarProductoOfertaDia(productoOfertaDia);
  }
  Future<Map<String,dynamic>> modificarProductoOfertaDia(ProductoOfertaDia productoOfertaDia){
    return productoOfertaDiaRepository.modificarProductoOfertaDia(productoOfertaDia);
  }
  Future<Map<String,dynamic>> eliminarProductoOfertaDia(String id){
    return productoOfertaDiaRepository.eliminarProductoOfertaDia(id);
  }
  Future<Map<String,dynamic>> obtenerProductoOfertaDia(String idProducto,String fecha){
    return productoOfertaDiaRepository.obtenerProductoOfertaDia(idProducto,fecha);
  }
}