import 'package:licoreriarocasapp/data/repositories/producto/producto_kardex_repository.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';

class UseCaseProductoKardex{
  ProductoKardexRepository productoKardexRepository=ProductoKardexRepository();
  Future<Map<String,dynamic>> registrarProductoKardex(String idUsuario,String idSucursal,String idProducto,ProductoKardex productoKardex){
    return productoKardexRepository.registrarProductoKardex(idUsuario, idSucursal, idProducto, productoKardex);
  }
  Future<bool> modificarProductoKardex(ProductoKardex productoKardex){
    return productoKardexRepository.modificarProductoKardex(productoKardex);
  }
  Future<bool> eliminarProductoKardex(ProductoKardex productoKardex){
    return productoKardexRepository.eliminarProductoKardex(productoKardex.id);
  }
  Future<Map<String,dynamic>> obtenerProductoKardexs(String idSucursal,String idProducto,String fechaInicial,String fechaFinal){
    return productoKardexRepository.obtenerProductoKardexs(idSucursal,idProducto,fechaInicial,fechaFinal);
  }
}