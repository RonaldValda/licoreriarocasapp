import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:licoreriarocasapp/ui/pages/principal/page_principal.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class PageAutenticacion extends StatefulWidget {
  PageAutenticacion({Key? key}) : super(key: key);

  @override
  _PageAutenticacionState createState() => _PageAutenticacionState();
}

class _PageAutenticacionState extends State<PageAutenticacion> {
  TextEditingController? controllerEmail;
  TextEditingController? controllerPassword;
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  void initState() {
    super.initState();
    controllerEmail=TextEditingController(text: "administrador@email.com");
    controllerPassword=TextEditingController(text: "12345");
  }
  @override
  Widget build(BuildContext context) {
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          //mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left:10,right: 10,top: 10,bottom: 0),
              child: Column(
                children: [
                  TextFFBasico(
                    controller: controllerEmail!, 
                    labelText: "Email", 
                    onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerPassword!, 
                    labelText: "Clave de acceso", 
                    isPassword: true,
                    onChanged: (x){}
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width/2,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Colors.blueAccent,
                      width: 4
                    )
                  )
                ),
                onPressed: (){
                  useCaseUsuario.autenticarUsuario(controllerEmail!.text, controllerPassword!.text, "Creada")
                  .then((resultado) {
                    if(resultado["completado"]){
                      usuarioProvider.setUsuario(resultado["usuario"],notificar: false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PagePrincipal();
                          }
                        )
                      );
                    }else{}
                  });
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ingresar "),
                    Icon(Icons.login),
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}