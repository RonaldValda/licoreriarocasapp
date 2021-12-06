class Sucursal{
  String id;
  String descripcion;
  String direccion;
  String fechaRegistro;
  bool estado;
  List<dynamic> telefonos;
  List<dynamic> coordenadas;
  bool seleccionado=false;
  Sucursal({
    required this.id,
    required this.descripcion,
    required this.direccion,
    required this.fechaRegistro,
    required this.estado,
    required this.telefonos,
    required this.coordenadas
  });
  factory Sucursal.vacio(){
    return Sucursal(
      id: "", descripcion: "", direccion: "", fechaRegistro: "", 
      estado: false, telefonos: ["","",""], coordenadas: []
    );
  }
  factory Sucursal.fromMap(Map<String,dynamic> data){
    return Sucursal(
      id: data["id"]??"", 
      descripcion: data["descripcion"]??"", 
      direccion: data["direccion"]??"", 
      fechaRegistro: data["fecha_registro"]??"",
      estado: data["estado"]??false, 
      telefonos: data["telefonos"]??["","",""], 
      coordenadas: data["coordenadas"]??[]
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "descripcion":this.descripcion,
      "direccion":this.direccion,
      "fecha_registro":this.fechaRegistro,
      "estado":this.estado,
      "telefonos":this.telefonos,
      "coordenadas":this.coordenadas
    };
  }
  factory Sucursal.copyWith(Sucursal s){
    return Sucursal(
      id: s.id, descripcion: s.descripcion, direccion: s.direccion, 
      fechaRegistro: s.fechaRegistro, estado: s.estado, telefonos: s.telefonos, 
      coordenadas: s.coordenadas
    );
  }
}
class SucursalAlmacen{
  String id;
  String localizacion;
  bool seleccionado=false;
  SucursalAlmacen({
    required this.id,
    required this.localizacion
  });
  factory SucursalAlmacen.vacio(){
    return SucursalAlmacen(id: "", localizacion: "");
  }
  factory SucursalAlmacen.fromMap(Map<String,dynamic> data){
    return SucursalAlmacen(id: data["id"]??"", localizacion: data["localizacion"]??"");
  }
  factory SucursalAlmacen.copyWith(SucursalAlmacen s){
    return SucursalAlmacen(id: s.id, localizacion: s.localizacion);
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "localizacion":this.localizacion
    };
  }
}