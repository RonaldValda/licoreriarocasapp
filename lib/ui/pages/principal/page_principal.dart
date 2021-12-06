import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/principal/widgets/container_listado_productos.dart';
import 'package:licoreriarocasapp/ui/pages/principal/widgets/drawer_menu.dart';
class PagePrincipal extends StatefulWidget {
  PagePrincipal({Key? key}) : super(key: key);

  @override
  _PagePrincipalState createState() => _PagePrincipalState();
}

class _PagePrincipalState extends State<PagePrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo"),
        elevation:0.5,
      ),
      drawer: DrawerMenu(),
      body: ContainerListadoProductos(),
    );
  }
}