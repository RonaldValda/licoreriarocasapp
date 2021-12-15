import 'package:licoreriarocasapp/domain/entities/producto.dart';

abstract class AbstractProductoReposytory{
  Future<Map<String,dynamic>> registrarProducto(String idEtiqueta,Producto producto);
  Future<bool> modificarProducto(Producto producto);
  Future<bool> eliminarProducto(String id);
  Future<Map<String,dynamic>> obtenerProductos(String idEtiqueta);
  Future<Map<String,dynamic>> obtenerProductosGeneral();
  Future<Map<String,dynamic>> buscarProductoContenido(String contenido);
}

abstract class AbstractProductoKardexRepository{
  Future<Map<String,dynamic>> registrarProductoKardex(String idUsuario,String idSucursal,String idProductoKardex,ProductoKardex productoKardex);
  Future<bool> modificarProductoKardex(ProductoKardex productoKardex);
  Future<bool> eliminarProductoKardex(String id);
  Future<Map<String,dynamic>> obtenerProductoKardexs(String idSucursal,String idProducto,String fechaInicial,String fechaFinal);
  
}
/*
abstract class AbstractProductoCompraRepository{
  Future<Map<String,dynamic>> registrarCompraProducto(String id)
}
*/