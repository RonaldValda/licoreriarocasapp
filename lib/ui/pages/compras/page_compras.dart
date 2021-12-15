import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/ui/pages/compra_registro/page_compra_registro.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:provider/provider.dart';
class PageCompras extends StatefulWidget {
  PageCompras({Key? key}) : super(key: key);

  @override
  _PageComprasState createState() => _PageComprasState();
}

class _PageComprasState extends State<PageCompras> {
  List<Compra> compras=[];
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Compras"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: compras.length,
                itemBuilder: (context, index) {
                  return Container();
                },
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          compraProvider.setCompra(Compra.vacio(),notificar: false);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return PageCompraRegistro();
              }
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}