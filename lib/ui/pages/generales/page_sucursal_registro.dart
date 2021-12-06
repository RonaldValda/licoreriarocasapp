import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_sucursal.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
class PageSucursalRegistro extends StatefulWidget {
  PageSucursalRegistro({Key? key,required this.sucursal}) : super(key: key);
  final Sucursal sucursal;
  @override
  _PageSucursalRegistroState createState() => _PageSucursalRegistroState();
}

class _PageSucursalRegistroState extends State<PageSucursalRegistro> {
  UseCaseSucursal useCaseSucursal=UseCaseSucursal();
  TextEditingController? controllerDescripcion;
  TextEditingController? controllerDireccion;
  TextEditingController? controllerTelefono1;
  TextEditingController? controllerTelefono2;
  TextEditingController? controllerTelefono3;
  @override
  void initState() {
    controllerDescripcion=TextEditingController(text: "");
    controllerDireccion=TextEditingController(text: "");
    controllerTelefono1=TextEditingController(text: "");
    controllerTelefono2=TextEditingController(text: "");
    controllerTelefono3=TextEditingController(text: "");
    controllerDescripcion!.text=widget.sucursal.descripcion;
    controllerDireccion!.text=widget.sucursal.direccion;
    controllerTelefono1!.text=widget.sucursal.telefonos[0];
    controllerTelefono2!.text=widget.sucursal.telefonos[1];
    controllerTelefono3!.text=widget.sucursal.telefonos[2];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        widget.sucursal.id="";
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.sucursal.id!=""?"Datos sucursal":"Nueva sucursal"),
          leading: IconButton(
            onPressed: (){
              widget.sucursal.id="";
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ), 
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child:ListView(
                  padding: EdgeInsets.only(top: 10,bottom: 0,left: 5,right: 5),
                  children: [
                    TextFFBasico(
                      controller: controllerDescripcion!, 
                      labelText: "Descripción", 
                      onChanged: (x){
                        widget.sucursal.descripcion=x;
                      }
                    ),
                    SizedBox(height: 7,),
                    TextFFBasico(
                      controller: controllerDireccion!, 
                      labelText: "Dirección", 
                      onChanged: (x){
                        widget.sucursal.direccion=x;
                      }
                    ),
                    SizedBox(height: 7,),
                    TextFFBasico(
                      controller: controllerTelefono1!, 
                      labelText: "Teléfono 1", 
                      onChanged: (x){
                        widget.sucursal.telefonos[0]=x;
                      }
                    ),
                    SizedBox(height: 7,),
                    TextFFBasico(
                      controller: controllerTelefono2!, 
                      labelText: "Teléfono 2", 
                      onChanged: (x){
                        widget.sucursal.telefonos[1]=x;
                      }
                    ),
                    SizedBox(height: 7,),
                    TextFFBasico(
                      controller: controllerTelefono3!, 
                      labelText: "Teléfono 3", 
                      onChanged: (x){
                        widget.sucursal.telefonos[2]=x;
                      }
                    ),
                    SizedBox(height: 7,),
                  ],
                ) 
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: MaterialButton(
                  clipBehavior: Clip.antiAlias,
                  child: Text(widget.sucursal.id!=""?"Modificar":"Registrar",style: TextStyle(
                    color: Colors.white70,fontSize: 20
                  ),),
                  onPressed: (){
                    if(widget.sucursal.id==""){
                      useCaseSucursal.registrarSucursal(widget.sucursal)
                      .then((resultado){
                        if(resultado["completado"]){
                          Sucursal s=resultado["sucursal"];
                          widget.sucursal.id=s.id;
                          widget.sucursal.fechaRegistro=s.fechaRegistro;
                          Navigator.pop(context);
                        }else{
                          print("Error");
                        }
                      });
                    }else{
                      useCaseSucursal.modificarSucursal(widget.sucursal)
                      .then((completado){
                        if(completado){
                          Navigator.pop(context);
                        }
                      });
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}