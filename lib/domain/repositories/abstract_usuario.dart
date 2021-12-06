import 'package:licoreriarocasapp/domain/entities/usuario.dart';

abstract class AbstractUsuarioRepository{
  Future<Map<String,dynamic>> registrarUsuario(Usuario usuario);
  Future<bool> modificarUsuario(Usuario usuario);
  Future<bool> eliminarUsuario(String id);
  Future<Map<String,dynamic>> autenticarUsuario(String email,String password,String medioRegistro);
  Future<Map<String,dynamic>> obtenerUsuarios();
}