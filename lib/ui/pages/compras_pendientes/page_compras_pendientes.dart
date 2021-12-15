
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_compra.dart';
import 'package:licoreriarocasapp/ui/pages/compra_confirmacion/page_compra_confirmacion.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:provider/provider.dart';
class PageComprasPendientes extends StatefulWidget {
  PageComprasPendientes({Key? key}) : super(key: key);

  @override
  _PageComprasPendientesState createState() => _PageComprasPendientesState();
}

class _PageComprasPendientesState extends State<PageComprasPendientes> {
  UseCaseCompra useCaseCompra=UseCaseCompra();
  List<Compra> compras=[];
  late UsuarioProvider usProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      usProvider=Provider.of<UsuarioProvider>(context,listen: false);
      useCaseCompra.obtenerPreComprasPendientes(usProvider.usuario.tipoUsuario=="Vendedor"?usProvider.sucursal.id:"",usProvider.usuario.tipoUsuario)
      .then((resultado){
        if(resultado["completado"]){
          compras=resultado["compras"];
          setState(() {
            
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    compras.sort((a,b)=>a.fechaPreCompraMovimiento.compareTo(b.fechaPreCompraMovimiento));
    return Scaffold(
      appBar: AppBar(
        title: Text("Compras pendientes"),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 5),
          itemCount: compras.length,
          itemBuilder: (context, index) {
            var compra=compras[index];
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
                title: Text("${compra.usuarioPreCompra.nombres} ${compra.usuarioPreCompra.apellidos}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${compra.fechaPreCompraMovimiento}"),
                    Text("N° comprobante: ${compra.nroComprobante}")
                  ],
                ),
                //trailing: Text("${compra.costoTotal} "+r"$"),
                onTap: ()async{
                  
                  compraProvider.setCompraCarrito(Compra.copyWith(compra),notificar: false);
                  compraProvider.compraCarrito.usuarioConfirmacion=usProvider.usuario;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return PageCompraConfirmacion();
                      }
                    )
                  );
                  compra=Compra.copyWith(compraProvider.compraCarrito);
                  compras.removeWhere((element) => element.id==compra.id);
                  compras.add(compra);
                  
                  setState(() {
                    
                  });
                  compraProvider.setCompraCarrito(Compra.vacio(),notificar: false);
                },
              )
            );
          },
        )
      ),
    );
  }
}