import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';

class UsuarioProvider extends ChangeNotifier{
  Usuario usuario=Usuario.vacio();
  void setUsuario(Usuario usuario,{bool notificar=true}){
    this.usuario=usuario;
    if(notificar){
      notifyListeners();
    }
  }
}