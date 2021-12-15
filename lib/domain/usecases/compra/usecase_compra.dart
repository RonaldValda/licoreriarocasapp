import 'package:licoreriarocasapp/data/repositories/compra/compra_repository.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';

class UseCaseCompra{
  CompraRepository compraRepository=CompraRepository();

  Future<Map<String,dynamic>> registrarPreCompra(Compra compra){
    return compraRepository.registrarPreCompra(compra);
  }
  Future<bool> modificarPreCompra(Compra compra){
    return compraRepository.modificarPreCompra(compra);
  }
  Future<bool> terminarPreCompra(Compra compra){
    return compraRepository.terminarPreCompra(compra);
  }
  Future<Map<String,dynamic>> obtenerPreComprasPendientes(String idSucursal,String tipoUsuarioConfirmacion){
    return compraRepository.obtenerPreComprasPendientes(idSucursal,tipoUsuarioConfirmacion);
  }
  Future<Map<String,dynamic>> responderConfirmacionPreCompra(Compra compra){
    return compraRepository.responderConfirmacionPreCompra(compra);
  }
}