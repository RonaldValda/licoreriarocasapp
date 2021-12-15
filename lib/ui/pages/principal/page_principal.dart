import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/entities/venta.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/ui/pages/principal/widgets/container_listado_productos.dart';
import 'package:licoreriarocasapp/ui/pages/principal/widgets/container_listado_productos_venta.dart';
import 'package:licoreriarocasapp/ui/pages/principal/widgets/drawer_menu.dart';
import 'package:fluttericon/typicons_icons.dart' as typicons_icons;
import 'package:fluttericon/brandico_icons.dart' as brandico;
import 'package:fluttericon/elusive_icons.dart' as elusive;
import 'package:fluttericon/entypo_icons.dart' as entypo;
import 'package:fluttericon/font_awesome5_icons.dart' as font_a5;
import 'package:fluttericon/font_awesome_icons.dart' as font_a;
import 'package:fluttericon/fontelico_icons.dart' as fontelico;
import 'package:fluttericon/iconic_icons.dart' as iconic;
import 'package:fluttericon/linearicons_free_icons.dart' as linear_icon;
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/provider/venta/ventaProvider.dart';
import 'package:provider/provider.dart';
class PagePrincipal extends StatefulWidget {
  PagePrincipal({Key? key}) : super(key: key);

  @override
  _PagePrincipalState createState() => _PagePrincipalState();
}

class _PagePrincipalState extends State<PagePrincipal> {
  int index=0;
  UseCaseProducto useCaseProducto=UseCaseProducto();
  List<Producto> productos=[];
  List<CompraProducto> compraProductos=[];
  late CompraProvider cmpProvider;
  late UsuarioProvider usProvider;
  late VentaProvider vntProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      cmpProvider=Provider.of<CompraProvider>(context,listen: false);
      usProvider=Provider.of<UsuarioProvider>(context,listen: false);
      vntProvider=Provider.of<VentaProvider>(context,listen: false);
      cmpProvider.compraCarrito.usuarioPreCompra=usProvider.usuario;
      cmpProvider.setCompra(Compra.vacio());
      useCaseProducto.obtenerProductosGeneral()
      .then((resultado){
        if(resultado["completado"]){
          productos=resultado["productos"];
          productos.forEach((producto) {
            CompraProducto cp=CompraProducto.vacio();
            cp.producto=producto;
            cmpProvider.compra.compraProductos.add(cp);
            VentaProducto vp=VentaProducto.vacio();
            vp.precioUnitario=producto.precio;
            vp.producto=producto;
            vntProvider.venta.ventaProductos.add(vp);
          });
          setState(() {
            
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rocas"),
          elevation:0.5,
          bottom: TabBar(
            onTap: (val){
              setState(() {
                index=val;
              });
            },
            tabs: [
              Tab(
                child: Text("Comprar"),
                icon: Icon(Icons.shopping_cart_rounded,size:30),
              ),
              Tab(
                child: Text("Vender"),
                icon: Icon(Icons.shopping_cart_outlined,size: 30,),
              ),
            ],
          ),
        ),
        drawer: DrawerMenu(),
        body: index==0?ContainerListadoProductosCompra():ContainerListadoProductosVenta(),
      ),
    );
  }
}