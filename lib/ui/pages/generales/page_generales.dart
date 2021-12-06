import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_categorias.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_configuracion_empresa.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_sucursales_empresa.dart';
class PageGenerales extends StatefulWidget {
  PageGenerales({Key? key}) : super(key: key);

  @override
  _PageGeneralesState createState() => _PageGeneralesState();
}

class _PageGeneralesState extends State<PageGenerales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generales"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            ListTile(
              title: Text("Configuración empresa"),
              trailing: Icon(
                Icons.arrow_forward_ios
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageConfiguracionEmpresa();
                    }
                  )
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Sucursales empresa"),
              trailing: Icon(
                Icons.arrow_forward_ios
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageSucursalesEmpresa();
                    }
                  )
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Categorías, subcategorías y etiquetas"),
              trailing: Icon(
                Icons.arrow_forward_ios
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageCategorias();
                    }
                  )
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}