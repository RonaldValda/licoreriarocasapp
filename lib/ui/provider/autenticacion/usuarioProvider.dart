import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';

class UsuarioProvider extends ChangeNotifier{
  Usuario usuario=Usuario.vacio();
  Sucursal sucursal=Sucursal.vacio();
  void setUsuario(Usuario usuario,{bool notificar=true}){
    this.usuario=usuario;
    if(notificar){
      notifyListeners();
    }
  }
  void setSucursal(Sucursal sucursal,{bool notificar=true}){
    this.sucursal=sucursal;
    if(notificar) notifyListeners();
  }
}