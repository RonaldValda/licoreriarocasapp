import 'package:licoreriarocasapp/data/repositories/generales/subcategoria_repository.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';

class UseCaseSubcategoria{
  SubcategoriasRepository subcategoriasRepository=SubcategoriasRepository();
  Future<Map<String,dynamic>> registrarSubcategoria(String idCategoria,Subcategoria subcategoria){
    return subcategoriasRepository.registrarSubcategoria(idCategoria, subcategoria);
  }
  Future<bool> modificarSubcategoria(Subcategoria subcategoria){
    return subcategoriasRepository.modificarSubcategoria(subcategoria);
  }
  Future<bool> eliminarSubcategoria(Subcategoria subcategoria){
    return subcategoriasRepository.eliminarSubcategoria(subcategoria.id);
  }
}