import 'package:licoreriarocasapp/data/repositories/compra/compra_repository.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';

class UseCaseCompra{
  CompraRepository compraRepository=CompraRepository();

  Future<Map<String,dynamic>> registrarPreCompra(Compra compra,List<CompraProducto> compraProductos){
    return compraRepository.registrarPreCompra(compra,compraProductos);
  }
  Future<bool> modificarPreCompra(Compra compra){
    return compraRepository.modificarPreCompra(compra);
  }
  Future<bool> terminarPreCompra(Compra compra){
    return compraRepository.terminarPreCompra(compra);
  }
   
}