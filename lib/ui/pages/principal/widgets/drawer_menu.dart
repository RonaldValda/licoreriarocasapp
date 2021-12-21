import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/ui/pages/cliente/page_clientes.dart';
import 'package:licoreriarocasapp/ui/pages/compras/page_compras.dart';
import 'package:licoreriarocasapp/ui/pages/compras_pendientes/page_compras_pendientes.dart';
import 'package:licoreriarocasapp/ui/pages/generales/page_generales.dart';
import 'package:licoreriarocasapp/ui/pages/producto/page_productos.dart';
import 'package:licoreriarocasapp/ui/pages/producto_kardex/page_producto_kardex.dart';
import 'package:licoreriarocasapp/ui/pages/proveedores/page_proveedores.dart';
import 'package:licoreriarocasapp/ui/pages/usuario/page_usuarios.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:provider/provider.dart';
class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
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
            if(usuarioProvider.usuario.tipoUsuario=="Administrador")
            listViewAdministrador(context),
            if(usuarioProvider.usuario.tipoUsuario=="Vendedor")
            listViewVendedor(context),
            if(usuarioProvider.usuario.tipoUsuario=="Marketing")
            listViewMarketing(context),
            if(usuarioProvider.usuario.tipoUsuario=="Gerente")
            listViewGerente(context)
          ],
        ),
      ),
    );
  }
  Widget listViewVendedor(BuildContext context){
    return Expanded(
      child: ListView(
        children: [
          listTileComprasPendientes(context),
        ],
      ),
    );
  }
  Widget listViewAdministrador(BuildContext context){
    return Expanded(
      child: ListView(
        children: [
          listTileProductos(context),
          listTileProveedores(context),
          listTileCompras(context),
          listTileComprasPendientes(context),
        ],
      ),
    );
  }
  Widget listViewMarketing(BuildContext context){
    return Expanded(
      child: ListView(
        children: [
          listTileProductos(context),
        ],
      ),
    );
  }
  Widget listViewGerente(BuildContext context){
    return Expanded(
      child: ListView(
        children: [
          listTileGenerales(context),
          listTileProductos(context),
          listTileKardexProductos(context),
          listTileProveedores(context),
          listTileCompras(context),
          listTileComprasPendientes(context),
          listTileUsuarios(context),
          listTileClientes(context),
        ],
      ),
    );
  }
  ListTile listTileProductos(BuildContext context) {
    return ListTile(
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
    );
  }
  Widget listTileGenerales(BuildContext context){
    return ListTile(
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
    );
  }
  Widget listTileKardexProductos(BuildContext context){
    return ListTile(
      title: Text("Kardex de productos"),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageProductoKardex();
            }
          )
        );
      },
    );
  }
  Widget listTileProveedores(BuildContext context){
    return ListTile(
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
    );
  }
  Widget listTileCompras(BuildContext context){
    return ListTile(
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
    );
  }
  Widget listTileComprasPendientes(BuildContext context){
    return ListTile(
      title: Text("Compras pendientes"),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageComprasPendientes();
            }
          )
        );
      },
    );
  }
  Widget listTileUsuarios(BuildContext context){
    return ListTile(
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
    );
  }

  Widget listTileClientes(BuildContext context) {
    return ListTile(
      title: Text("Clientes"),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageClientes();
            }
          )
        );
      },
    );
  }
}