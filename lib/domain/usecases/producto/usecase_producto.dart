import 'package:licoreriarocasapp/data/repositories/producto/producto_repository.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';

class UseCaseProducto{
  ProductoRepository productoRepository=ProductoRepository();
  Future<Map<String,dynamic>> registrarProducto(String idEtiqueta,Producto producto){
    return productoRepository.registrarProducto(idEtiqueta, producto);
  }
  Future<bool> modificarProducto(Producto producto){
    return productoRepository.modificarProducto(producto);
  }
  Future<bool> eliminarProducto(Producto producto){
    return productoRepository.eliminarProducto(producto.id);
  }
  Future<Map<String,dynamic>> obtenerProductos(String idEtiqueta){
    return productoRepository.obtenerProductos(idEtiqueta);
  }
  
  Future<Map<String,dynamic>> buscarProductoContenido(String contenido){
    return productoRepository.buscarProductoContenido(contenido);
  }
  Future<Map<String,dynamic>> obtenerProductosGeneral(){
    return this.productoRepository.obtenerProductosGeneral();
  }
}
