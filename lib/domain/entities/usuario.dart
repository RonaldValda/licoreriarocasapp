class Usuario{
  String id;
  String linkFoto;
  String nombres;
  String apellidos;
  String imeiTelefono;
  String email;
  String password;
  String medioRegistro;
  String fechaRegistro;
  String fechaUltimoIngreso;
  String fechaPenultimoIngreso;
  String tipoUsuario;
  String telefono;
  bool estadoCuenta;
  Usuario({
    required this.id,
    required this.linkFoto,
    required this.nombres,
    required this.apellidos,
    required this.imeiTelefono,
    required this.email,
    required this.password,
    required this.medioRegistro,
    required this.fechaRegistro,
    required this.fechaUltimoIngreso,
    required this.fechaPenultimoIngreso,
    required this.tipoUsuario,
    required this.telefono,
    required this.estadoCuenta,
    
  });
  factory Usuario.vacio(){
    return Usuario(
      id: "",linkFoto: "", nombres: "", apellidos: "", 
      imeiTelefono: "", email: "", password: "", medioRegistro: "", fechaRegistro: "",
      fechaUltimoIngreso: "", fechaPenultimoIngreso: "",tipoUsuario: "", telefono: "", 
      estadoCuenta: false
    );
  }
  factory Usuario.fromMap(Map<String,dynamic> data){
    return Usuario(
      id: data["id"]??"", linkFoto: data["link_foto"]??"", 
      nombres: data["nombres"]??"", apellidos: data["apellidos"]??"", 
      imeiTelefono: data["imei_telefono"]??"", email: data["email"]??"",
      password: "", 
      medioRegistro: data["medio_registro"]??"",
      fechaRegistro: data["fecha_registro"]??"", 
      fechaUltimoIngreso: data["fecha_ultimo_ingreso"]??"",
      fechaPenultimoIngreso: data["fecha_penultimo_ingreso"]??"", 
      tipoUsuario: data["tipo_usuario"]??"", telefono: data["telefono"]??"", 
      estadoCuenta: data["estado_cuenta"]??false
    );
  }
  factory Usuario.copyWith(Usuario u){
    return Usuario(
      id: u.id, linkFoto: u.linkFoto, nombres: u.nombres, apellidos: u.apellidos, 
      imeiTelefono: u.imeiTelefono, email: u.email, password: u.password, 
      medioRegistro: u.medioRegistro, fechaRegistro: u.fechaRegistro, 
      fechaUltimoIngreso: u.fechaUltimoIngreso, fechaPenultimoIngreso: u.fechaPenultimoIngreso, 
      tipoUsuario: u.tipoUsuario, telefono: u.telefono, estadoCuenta: u.estadoCuenta
    );
  }
  Map<String,dynamic> toMap(){
    return<String,dynamic>{
      "id":this.id,
      "link_foto":this.linkFoto,
      "nombres":this.nombres,
      "apellidos":this.apellidos,
      "imei_telefono":this.imeiTelefono,
      "email":this.email,
      "password":this.password,
      "medio_registro":this.medioRegistro,
      "tipo_usuario":this.tipoUsuario,
      "telefono":this.telefono,
      "estado_cuenta":this.estadoCuenta
    };
  }
}