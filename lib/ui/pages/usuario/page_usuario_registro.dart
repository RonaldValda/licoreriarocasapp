import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';
import 'package:licoreriarocasapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:licoreriarocasapp/ui/pages/usuario/widgets/dropdown_tipo_usuario.dart';
import 'package:licoreriarocasapp/ui/widgets/button_registro.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
class PageUsuarioRegistro extends StatefulWidget {
  PageUsuarioRegistro({Key? key,required this.usuario}) : super(key: key);
  final Usuario usuario;
  @override
  _PageUsuarioRegistroState createState() => _PageUsuarioRegistroState();
}

class _PageUsuarioRegistroState extends State<PageUsuarioRegistro> {
  TextEditingController? controllerNombres;
  TextEditingController? controllerApellidos;
  TextEditingController? controllerEmail;
  TextEditingController? controllerPassword;
  TextEditingController? controllerImei;
  TextEditingController? controllerTelefono;
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  void initState() {
    super.initState();
    controllerNombres=TextEditingController(text: widget.usuario.nombres);
    controllerApellidos=TextEditingController(text: widget.usuario.apellidos);
    controllerEmail=TextEditingController(text: widget.usuario.email);
    controllerPassword=TextEditingController(text: "");
    controllerImei=TextEditingController(text: widget.usuario.imeiTelefono);
    controllerTelefono=TextEditingController(text: widget.usuario.telefono);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            widget.usuario.id="";
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back)
        ),
        title: Text(widget.usuario.id==""?"Nuevo Usuario":"Datos usuario"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(5),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  DropdownTipoUsuario(usuario: widget.usuario),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerNombres!, 
                    labelText: "Nombres", 
                    onChanged: (x){
                      widget.usuario.nombres=x;
                    }
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerApellidos!, 
                    labelText: "Apellidos", 
                    onChanged: (x){
                      widget.usuario.apellidos=x;
                    }
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerEmail!, 
                    labelText: "Email", 
                    onChanged: (x){
                      widget.usuario.email=x;
                    }
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerPassword!, 
                    labelText: "Contraseña", 
                    isPassword: true,
                    onChanged: (x){
                      widget.usuario.password=x;
                    }
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerImei!, 
                    labelText: "Imei teléfono", 
                    onChanged: (x){
                      widget.usuario.imeiTelefono=x;
                    }
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerTelefono!, 
                    labelText: "Teléfono", 
                    onChanged: (x){
                      widget.usuario.telefono=x;
                    }
                  ),
                  SizedBox(height: 5,),
                  SwitchListTile(
                    title: Text("Estado cuenta (${widget.usuario.estadoCuenta?"Activo":"Inactivo"})"),
                    value: widget.usuario.estadoCuenta, 
                    onChanged: (value){
                      widget.usuario.estadoCuenta=value;
                      setState(() {
                        
                      });
                    }
                  )
                ],
              )
            ),
            ButtonRegistro(
              texto: widget.usuario.id==""?"Registrar":"Modificar", 
              onPressed: (){
                if(widget.usuario.id==""){
                  widget.usuario.medioRegistro="Creada";
                  useCaseUsuario.registrarUsuario(widget.usuario)
                  .then((resultado) {
                    if(resultado["completado"]){
                      Navigator.pop(context);
                    }
                  });
                }else{
                  useCaseUsuario.modificarUsuario(widget.usuario)
                  .then((completado) {
                    if(completado){
                      Navigator.pop(context);
                    }
                  });
                }
              }
            )
          ],
        ),
      ),
    );
  }
}