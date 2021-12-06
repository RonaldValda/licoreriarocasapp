class Proveedor{
  String id;
  String ciNit;
  String nombres;
  String fechaRegistro;
  bool estado;
  Proveedor({
    required this.id,required this.ciNit,required this.nombres,required this.fechaRegistro,required this.estado
  });
  factory Proveedor.vacio(){
    return Proveedor(
      id: "",ciNit: "", nombres: "", fechaRegistro: "", estado: false
    );
  }
  factory Proveedor.copyWith(Proveedor p){
    return Proveedor(
      id: p.id, ciNit: p.ciNit,nombres: p.nombres, fechaRegistro: p.fechaRegistro, estado: p.estado
    );
  }
  factory Proveedor.fromMap(Map<String,dynamic> data){
    return Proveedor(
      id: data["id"]??"", ciNit: data["ci_nit"]??"",nombres: data["nombres"]??"", 
      fechaRegistro: data["fecha_registro"]??"", estado: data["estado"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "ci_nit":this.ciNit,
      "nombres":this.nombres,
      "fecha_registro":this.fechaRegistro,
      "estado":this.estado
    };
  }
}