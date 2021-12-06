import 'package:licoreriarocasapp/data/repositories/generales/categoria_repository.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';

class UseCaseCategoria{
  CategoriaRepository categoryRepository=CategoriaRepository();
  Future<Map<String,dynamic>> obtenerCategorias(){
    return categoryRepository.obtenerCategorias();
  }
  Future<Map<String,dynamic>> registrarCategoria(Categoria categoria){
    return categoryRepository.registrarCategoria(categoria);
  }
  Future<bool> modificarCategoria(Categoria categoria){
    return categoryRepository.modificarCategoria(categoria);
  }
  Future<bool> eliminarCategoria(Categoria categoria){
    return categoryRepository.eliminarCategoria(categoria.id);
  }
  Future<bool> registrarMuchasCategorias(List<String> nombresCategorias){
    return categoryRepository.registrarMuchasCategorias(nombresCategorias);
  }
}