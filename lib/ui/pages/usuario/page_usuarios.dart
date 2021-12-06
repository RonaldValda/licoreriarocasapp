
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';
import 'package:licoreriarocasapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:licoreriarocasapp/ui/pages/usuario/page_usuario_registro.dart';
class PageUsuarios extends StatefulWidget {
  PageUsuarios({Key? key}) : super(key: key);

  @override
  _PageUsuariosState createState() => _PageUsuariosState();
}

class _PageUsuariosState extends State<PageUsuarios> {
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  Usuario usuarioSel=Usuario.vacio();
  List<Usuario> usuarios=[];
  @override
  void initState() {
    super.initState();
    useCaseUsuario.obtenerUsuarios()
    .then((resultado) {
      if(resultado["completado"]){
        usuarios=resultado["usuarios"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  var usuario=usuarios[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5
                        )
                      )
                    ),
                    child: ListTile(
                      title: Text("${usuario.nombres} ${usuario.apellidos}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Medio registro: ${usuario.medioRegistro}"),
                          Text("Fecha registro: ${usuario.fechaRegistro}"),
                          Text("Tipo usuario: ${usuario.tipoUsuario}"),
                          Text("Estado: ${usuario.estadoCuenta?"Activo":"Inactivo"}"),
                        ],
                      ),
                      trailing: Container(
                        width: 70,
                        height: 50,
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: ()async{
                                  usuarioSel=Usuario.copyWith(usuario);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context){
                                        return PageUsuarioRegistro(usuario: usuarioSel);
                                      }
                                    )
                                  );
                                  if(usuarioSel.id!=""){
                                    usuarios.removeWhere((element) => element.id==usuarioSel.id);
                                    usuarios.add(Usuario.copyWith(usuarioSel));
                                    setState(() {
                                      
                                    });
                                  }
                                },
                                child: Icon(Icons.edit,color: Colors.blueGrey,),
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 35,
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  useCaseUsuario.eliminarUsuario(usuario)
                                  .then((completado){
                                    if(completado){
                                      usuarios.removeWhere((element) => element.id==usuario.id);
                                      setState(() {
                                        
                                      });
                                    }
                                  });
                                },
                                child: Icon(Icons.delete,color: Colors.redAccent,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  );
                },
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: ()async{
          usuarioSel=Usuario.vacio();
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return PageUsuarioRegistro(usuario: usuarioSel);
              }
            )
          );
          if(usuarioSel.id!=""){
            usuarios.add(Usuario.copyWith(usuarioSel));
            setState(() {
              
            });
          }
        },
      ),
    );
  }
}