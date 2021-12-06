import 'package:licoreriarocasapp/domain/entities/categoria.dart';
import 'package:licoreriarocasapp/domain/entities/configuracion_empresa.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';

abstract class AbstractConfiguracionEmpresaRepository{
  Future<Map<String,dynamic>> obtenerConfiguracionesEmpresa();
  Future<Map<String,dynamic>> registrarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa);
  Future<bool> modificarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa);
  Future<bool> eliminarConfiguracionEmpresa(String id);
}
abstract class AbstractSucursalRepository{
  Future<Map<String,dynamic>> obtenerSucursales();
  Future<Map<String,dynamic>> registrarSucursal(Sucursal sucursal);
  Future<bool> modificarSucursal(Sucursal sucursal);
  Future<bool> eliminarSucursal(String id); 
}
abstract class AbstractSucursalAlmacenRepository{
  Future<Map<String,dynamic>> obtenerSucursalAlmacenes(String idSucursal);
  Future<Map<String,dynamic>> registrarSucursalAlmacen(String idSucursal,SucursalAlmacen sucursalAlmacen);
  Future<bool> modificarSucursalAlmacen(SucursalAlmacen sucursalAlmacen);
  Future<bool> eliminarSucursalAlmacen(String id);
}
abstract class AbstractCategoriaRepository{
  Future<Map<String,dynamic>> obtenerCategorias();
  Future<Map<String,dynamic>> registrarCategoria(Categoria categoria);
  Future<bool> modificarCategoria(Categoria categoria);
  Future<bool> eliminarCategoria(String id);
  Future<bool> registrarMuchasCategorias(List<String> nombres_categorias);
}
abstract class AbstractSubcategoriaRepository{
  Future<Map<String,dynamic>> obtenerSubcategoria(Categoria categoria);
  Future<Map<String,dynamic>> registrarSubcategoria(String idCategoria,Subcategoria subcategoria);
  Future<bool> modificarSubcategoria(Subcategoria subcategoria);
  Future<bool> eliminarSubcategoria(String id);
}
abstract class AbstractEtiquetaRepository{
  Future<Map<String,dynamic>> registrarEtiqueta(String idSubcategoria,Etiqueta etiqueta);
  Future<bool> modificarEtiqueta(Etiqueta etiqueta);
  Future<bool> eliminarEtiqueta(String id);
}