import 'package:licoreriarocasapp/data/repositories/generales/sucursal_almacen_repository.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';

class UseCaseSucursalAlmacen{
  SucursalAlmacenRepository sucursalAlmacenRepository=SucursalAlmacenRepository();
  Future<Map<String,dynamic>> registrarSucursalAlmacen(String idSucursal,SucursalAlmacen sucursalAlmacen){
    return sucursalAlmacenRepository.registrarSucursalAlmacen(idSucursal,sucursalAlmacen);
  }
  Future<bool> modificarSucursalAlmacen(SucursalAlmacen sucursalAlmacen){
    return sucursalAlmacenRepository.modificarSucursalAlmacen(sucursalAlmacen);
  }
  Future<bool> eliminarSucursalAlmacen(SucursalAlmacen sucursalAlmacen){
    return sucursalAlmacenRepository.eliminarSucursalAlmacen(sucursalAlmacen.id);
  }
  Future<Map<String,dynamic>> obtenerSucursalAlmacenes(String idSucursal){
    return sucursalAlmacenRepository.obtenerSucursalAlmacenes(idSucursal);
  }
}