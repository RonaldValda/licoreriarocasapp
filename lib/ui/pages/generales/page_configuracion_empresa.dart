import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/configuracion_empresa.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_configuracion_empresa.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_configuracion_empresa_registro.dart';
class PageConfiguracionEmpresa extends StatefulWidget {
  PageConfiguracionEmpresa({Key? key}) : super(key: key);

  @override
  _PageConfiguracionEmpresaState createState() => _PageConfiguracionEmpresaState();
}

class _PageConfiguracionEmpresaState extends State<PageConfiguracionEmpresa> {
  List<ConfiguracionEmpresa> configuracionesEmpresa=[];
  UseCaseConfiguracionEmpresa ucConfiguracionEmpresa=UseCaseConfiguracionEmpresa();
  ConfiguracionEmpresa configuracionSel=ConfiguracionEmpresa.vacio();
  @override
  void initState() {
    super.initState();
    ucConfiguracionEmpresa.obtenerConfiguracionesEmpresa()
    .then((resultado) {
      if(resultado["completado"]){
        configuracionesEmpresa=resultado["configuraciones_empresa"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuraciones empresa"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: configuracionesEmpresa.length,
          itemBuilder: (context, index) {
            var configuracion=configuracionesEmpresa[index];
            return Column(
              children: [
                ListTile(
                  leading: IconButton(
                    onPressed: (){

                    }, 
                    icon: configuracion.estado?
                    Icon(Icons.check,color:Colors.green,size: 40,):
                    Icon(Icons.close,color:Colors.red,size: 40,),
                  ),
                  title: Text("Configuración ${index+1}"),
                  trailing: Container(
                    width: 100,
                    height: 50,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async{
                            configuracionSel=ConfiguracionEmpresa.copyWith(configuracion);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){
                                  return PageConfiguracionEmpresaRegistro(configuracion: configuracionSel,);
                                }
                              )
                            );
                            configuracionSel=ConfiguracionEmpresa.vacio();
                          }, 
                          icon: Icon(Icons.edit,color: Colors.blue,size: 30,)
                        ),
                        IconButton(
                          onPressed: () {
                            
                          }, 
                          icon: Icon(Icons.delete,color: Colors.red,size: 30,)
                        ),
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return PageConfiguracionEmpresaRegistro(configuracion: configuracionSel,);
              }
            )
          );
          if(configuracionSel.id!=""){
            setState(() {
              configuracionesEmpresa.add(configuracionSel);
            });
          }
        },
        child: Icon(Icons.add,size: 40,),
      ),
    );
  }
}