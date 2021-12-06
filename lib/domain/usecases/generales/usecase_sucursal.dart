import 'package:licoreriarocasapp/data/repositories/generales/sucursal_repository.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';

class UseCaseSucursal{
  SucursalRepository sucursalRepository=SucursalRepository();
  Future<Map<String,dynamic>> obtenerSucursales() async{
    return sucursalRepository.obtenerSucursales();
  }
  Future<Map<String,dynamic>> registrarSucursal(Sucursal sucursal) async{
    return sucursalRepository.registrarSucursal(sucursal);
  }
  Future<bool> modificarSucursal(Sucursal sucursal) async{
    return sucursalRepository.modificarSucursal(sucursal);
  }
  Future<bool> eliminarSucursal(Sucursal sucursal) async{
    return sucursalRepository.eliminarSucursal(sucursal.id);
  }
}