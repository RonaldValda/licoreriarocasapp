import 'package:licoreriarocasapp/data/repositories/generales/etiqueta_repository.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';

class UseCaseEtiqueta{
  EtiquetaRepository etiquetaRepository=EtiquetaRepository();
  Future<Map<String,dynamic>> registrarEtiqueta(String idSubcategoria,Etiqueta etiqueta){
    return etiquetaRepository.registrarEtiqueta(idSubcategoria, etiqueta);
  }
  Future<bool> modificarEtiqueta(Etiqueta etiqueta){
    return etiquetaRepository.modificarEtiqueta(etiqueta);
  }
  Future<bool> eliminarEtiqueta(Etiqueta etiqueta){
    return etiquetaRepository.eliminarEtiqueta(etiqueta.id);
  }
}