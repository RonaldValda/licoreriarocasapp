import 'package:licoreriarocasapp/domain/entities/configuracion_empresa.dart';

abstract class AbstractConfiguracionServidorRepository{
  Future<Map<String,dynamic>> guardarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa);
  Future<Map<String,dynamic>> obtenerConfiguracionEmpresa();
}