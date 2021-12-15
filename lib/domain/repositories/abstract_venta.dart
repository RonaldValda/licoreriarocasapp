import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/domain/entities/producto_oferta_dia.dart';

abstract class AbstractClienteRepository{
  Future<Map<String,dynamic>> registrarCliente(Cliente cliente);
  Future<Map<String,dynamic>> modificarCliente(Cliente cliente);
  Future<Map<String,dynamic>> eliminarCliente(String id);
  Future<Map<String,dynamic>> obtenerClientes();
  Future<Map<String,dynamic>> buscarCliente(String ciNit,String nombres);
}
abstract class AbstractProductoOfertaDia{
  Future<Map<String,dynamic>> registrarProductoOfertaDia(ProductoOfertaDia productoOfertaDia);
  Future<Map<String,dynamic>> modificarProductoOfertaDia(ProductoOfertaDia productoOfertaDia);
  Future<Map<String,dynamic>> eliminarProductoOfertaDia(String id);
  Future<Map<String,dynamic>> obtenerProductoOfertaDia(String idProducto,String fecha);
}