import 'package:licoreriarocasapp/domain/entities/producto.dart';

class Cliente{
  String id;
  String ciNit;
  String linkFoto;
  String nombres;
  String fechaNacimiento;
  String imeiTelefono;
  String email;
  String password;
  String medioRegistro;
  String fechaRegistro;
  String fechaUltimoIngreso;
  String fechaPenultimoIngreso;
  String telefono;
  bool estadoCuenta;
  Cliente({
    required this.id,
    required this.ciNit,
    required this.linkFoto,
    required this.nombres,
    required this.fechaNacimiento,
    required this.imeiTelefono,
    required this.email,
    required this.password,
    required this.medioRegistro,
    required this.fechaRegistro,
    required this.fechaUltimoIngreso,
    required this.fechaPenultimoIngreso,
    required this.telefono,
    required this.estadoCuenta,
    
  });
  factory Cliente.vacio(){
    return Cliente(
      id: "",ciNit: "",linkFoto: "", nombres: "", fechaNacimiento: "",
      imeiTelefono: "", email: "", password: "", medioRegistro: "", fechaRegistro: "",
      fechaUltimoIngreso: "", fechaPenultimoIngreso: "", telefono: "", 
      estadoCuenta: false
    );
  }
  factory Cliente.fromMap(Map<String,dynamic> data){
    return Cliente(
      id: data["id"]??"", ciNit: data["ci_nit"]??"",linkFoto: data["link_foto"]??"", 
      nombres: data["nombres"]??"", fechaNacimiento: data["fecha_nacimiento"]??"",
      imeiTelefono: data["imei_telefono"]??"", email: data["email"]??"",
      password: "", 
      medioRegistro: data["medio_registro"]??"",
      fechaRegistro: data["fecha_registro"]??"", 
      fechaUltimoIngreso: data["fecha_ultimo_ingreso"]??"",
      fechaPenultimoIngreso: data["fecha_penultimo_ingreso"]??"", 
      telefono: data["telefono"]??"", 
      estadoCuenta: data["estado_cuenta"]??false
    );
  }
  factory Cliente.copyWith(Cliente c){
    return Cliente(
      id: c.id,ciNit: c.ciNit, linkFoto: c.linkFoto, nombres: c.nombres, fechaNacimiento: c.fechaNacimiento,
      imeiTelefono: c.imeiTelefono, email: c.email, password: c.password, 
      medioRegistro: c.medioRegistro, fechaRegistro: c.fechaRegistro, 
      fechaUltimoIngreso: c.fechaUltimoIngreso, fechaPenultimoIngreso: c.fechaPenultimoIngreso, 
      telefono: c.telefono, estadoCuenta: c.estadoCuenta
    );
  }
  Map<String,dynamic> toMap(){
    return<String,dynamic>{
      "id":this.id,
      "ci_nit":this.ciNit,
      "link_foto":this.linkFoto,
      "nombres":this.nombres,
      "fecha_nacimiento":this.fechaNacimiento,
      "imei_telefono":this.imeiTelefono,
      "email":this.email,
      "password":this.password,
      "medio_registro":this.medioRegistro,
      "telefono":this.telefono,
      "estado_cuenta":this.estadoCuenta
    };
  }
}
class ClienteFavorito{
  String id;
  Producto producto;
  Cliente cliente;
  bool favorito;
  ClienteFavorito({
    required this.id, required this.producto,
    required this.cliente,required this.favorito
  });
  factory ClienteFavorito.vacio(){
    return ClienteFavorito(
      id: "", producto: Producto.vacio(), 
      cliente: Cliente.vacio(), 
      favorito: false
    );
  }
  factory ClienteFavorito.fromMap(Map<String,dynamic> data){
    return ClienteFavorito(
      id: data["id"]??"", producto: data["producto"]!=null?Producto.fromMap(data["producto"]):Producto.vacio(), 
      cliente: data["cliente"]!=null?Cliente.fromMap(data["cliente"]):Cliente.vacio(), favorito: data["favorito"]??false
    );
  }
  factory ClienteFavorito.copyWith(ClienteFavorito cf){
    return ClienteFavorito(
      id: cf.id, producto: Producto.copyWith(cf.producto), 
      cliente: Cliente.copyWith(cf.cliente), favorito: cf.favorito
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "producto":this.producto,
      "cliente":this.cliente,
      "favorito":this.favorito
    };
  }
}