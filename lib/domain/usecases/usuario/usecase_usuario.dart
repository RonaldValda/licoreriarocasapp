import 'package:licoreriarocasapp/data/repositories/usuario/usuario_repository.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';

class UseCaseUsuario{
  UsuarioRepository usuarioRepository=UsuarioRepository();
  Future<Map<String,dynamic>> registrarUsuario(Usuario usuario){
    return usuarioRepository.registrarUsuario(usuario);
  }
  Future<bool> modificarUsuario(Usuario usuario){
    return usuarioRepository.modificarUsuario(usuario);
  }
  Future<bool> eliminarUsuario(Usuario usuario){
    return usuarioRepository.eliminarUsuario(usuario.id);
  }
  Future<Map<String,dynamic>> autenticarUsuario(String email,String password,String medioRegistro){
    return usuarioRepository.autenticarUsuario(email,password,medioRegistro);
  }
  Future<Map<String,dynamic>> obtenerUsuarios(){
    return usuarioRepository.obtenerUsuarios();
  }
   
}