import 'package:licoreriarocasapp/data/repositories/generales/configuracion_empresa_repository.dart';
import 'package:licoreriarocasapp/domain/entities/configuracion_empresa.dart';

class UseCaseConfiguracionEmpresa{
  ConfiguracionEmpresaRepository configuracionEmpresaRepository=ConfiguracionEmpresaRepository();
  Future<Map<String,dynamic>> registrarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa){
    return configuracionEmpresaRepository.registrarConfiguracionEmpresa(configuracionEmpresa);
  }
  Future<bool> modificarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa){
    return configuracionEmpresaRepository.modificarConfiguracionEmpresa(configuracionEmpresa);
  }
  Future<bool> eliminarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa){
    return configuracionEmpresaRepository.eliminarConfiguracionEmpresa(configuracionEmpresa.id);
  }
  Future<Map<String,dynamic>> obtenerConfiguracionesEmpresa(){
    return configuracionEmpresaRepository.obtenerConfiguracionesEmpresa();
  }
}