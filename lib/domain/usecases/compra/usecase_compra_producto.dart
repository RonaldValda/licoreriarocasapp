import 'package:licoreriarocasapp/data/repositories/compra/compra_producto_repository.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';

class UseCaseCompraProducto{
  CompraProductoRepository compraProductoRepository=CompraProductoRepository();
  
  Future<Map<String,dynamic>> registrarCompraProducto(String idCompra,double costoTotal,CompraProducto compraProducto){
    return compraProductoRepository.registrarCompraProducto(idCompra,costoTotal,compraProducto);
  }
   
}