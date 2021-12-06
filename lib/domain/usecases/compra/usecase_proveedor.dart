import 'package:licoreriarocasapp/data/repositories/compra/proveedor_repository.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';

class UseCaseProveedor{
  ProveedorRepository proveedorRepository=ProveedorRepository();
  Future<Map<String,dynamic>> registrarProveedor(Proveedor proveedor){
    return proveedorRepository.registrarProveedor(proveedor);
  }
  Future<bool> modificarProveedor(Proveedor proveedor){
    return proveedorRepository.modificarProveedor(proveedor);
  }
  Future<bool> eliminarProveedor(Proveedor proveedor){
    return proveedorRepository.eliminarProveedor(proveedor.id);
  }
  Future<Map<String,dynamic>> obtenerProveedores(){
    return proveedorRepository.obtenerProveedores();
  }
  Future<Map<String,dynamic>> buscarProveedor(String ciNit,String nombres){
    return proveedorRepository.buscarProveedor(ciNit,nombres);
  }
}