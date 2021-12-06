import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/compra/page_compras.dart';
import 'package:licoreriarocasapp/ui/pages/compra/page_proveedores.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_generales.dart';
import 'package:licoreriarocasapp/ui/pages/producto/page_productos.dart';
import 'package:licoreriarocasapp/ui/pages/usuario/page_usuarios.dart';
class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: (){},
              child: Container(
                width:MediaQuery.of(context).size.width,
                height: 150,
                color: Colors.black12,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Generales"),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageGenerales();
                          }
                        )
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Productos"),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageProductos();
                          }
                        )
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Proveedores"),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageProveedores();
                          }
                        )
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Compras"),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageCompras();
                          }
                        )
                      );
                    },
                  ),
                  ListTile(
                    title: Text("Usuario"),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageUsuarios();
                          }
                        )
                      );
                    },
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}