import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';
import 'package:licoreriarocasapp/domain/entities/venta.dart';
import 'package:licoreriarocasapp/ui/pages/compra_registro/widgets/dialog_compra_producto_carrito.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/provider/venta/ventaProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class HorizontalDataTableVentaProductos extends StatefulWidget {
  HorizontalDataTableVentaProductos({Key? key}) : super(key: key);

  @override
  _HorizontalDataTableVentaProductosState createState() => _HorizontalDataTableVentaProductosState();
}

class _HorizontalDataTableVentaProductosState extends State<HorizontalDataTableVentaProductos> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  @override
  Widget build(BuildContext context) {
    final ventaProvider=Provider.of<VentaProvider>(context);
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    return Container(
      child: HorizontalDataTable(
        
        leftHandSideColumnWidth:150,
        rightHandSideColumnWidth: 240,
        isFixedHeader: true,
        headerWidgets: _getHeaderTable(usuarioProvider.usuario),
        leftSideItemBuilder: (context, index) {
          return _generateFirstColumnRow(context,index,ventaProvider);
        },
        rightSideItemBuilder: (context, index) {
          return _rowRight(ventaProvider,usuarioProvider.usuario,index);
        },
        itemCount: ventaProvider.ventaCarrito.ventaProductos.length,
        
        rowSeparatorWidget: const Divider(
          color: Colors.black38,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
        elevation: 5,
        rightSideChildren: [Container(width: 25,height: 20,color: Colors.red,)],
        leftSideChildren: [Container(width: 25,height: 20,color: Colors.red,)],
        verticalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.grey,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
        horizontalScrollbarStyle: const ScrollbarStyle(
          thumbColor: Colors.blueGrey,
          isAlwaysShown: true,
          thickness: 4.0,
          radius: Radius.circular(5.0),
        ),
      ),
     // height: MediaQuery.of(context).size.height/1.5,
    );
  }
  List<Widget> _getHeaderTable(Usuario usuario) {
    return [
      
      Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: _getHeaderItem(
                'Contenido' + (sortType == sortName ? (isAscending ? '↓' : '↑') : ''),
                150),
            onPressed: () {
              sortType = sortName;
              isAscending = !isAscending;
              //user.sortName(isAscending);
              setState(() {});
            },
          ),
        ],
      ),
      _getHeaderItem('Precio unitario', 80),
      _getHeaderItem('Cantidad', 80),
      _getHeaderItem('Total', 80),
    ];
  }
  Widget _getHeaderItem(String label, double width) {
    return Container(
      child:Center(child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
      /*child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: [
          
        ],
      ),*/
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }
  Widget _generateFirstColumnRow(BuildContext context, int index,VentaProvider ventaProvider){
    return Row(
      children: [
        SizedBox(width: 5,),
        rowItem(
          ventaProvider,ventaProvider.ventaCarrito.ventaProductos[index].producto.contenido, 135, Alignment.centerLeft,index
        ),
      ],
    );
  }
  Widget _rowRight(VentaProvider ventaProvider,Usuario usuario,index){
    return Row(
      children: <Widget>[
        rowItem(
          ventaProvider,ventaProvider.ventaCarrito.ventaProductos[index].precioUnitario.toString(), 80, Alignment.center,index
        ),
        rowItem(
          ventaProvider,ventaProvider.ventaCarrito.ventaProductos[index].cantidad.toString(), 80, Alignment.center,index
        ),
        rowItem(
          ventaProvider,(ventaProvider.ventaCarrito.ventaProductos[index].cantidad*ventaProvider.ventaCarrito.ventaProductos[index].precioUnitario).toString(), 80, Alignment.center,index
        ),
      ],
    );
  }
  Widget rowItem(VentaProvider ventaProvider,String texto,double width,AlignmentGeometry alignment,int index){
    return PopupMenuButton(
      elevation: 10,
      offset: const Offset(0, -35),
      color: Colors.white.withOpacity(0.8),

      child: Container(
        child: Row(
          children: [
            Container(
              alignment: alignment,
              height:32,
              child:Container(
                alignment: alignment,
                width: width,
                child: Text(texto,
                  textAlign: TextAlign.left,
                  semanticsLabel: "dadasdd",
                  softWrap: true,
                  style:TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal
                  )
                ),
              ),
              /*decoration: BoxDecoration(
                border: Border(
                  left:BorderSide(width: 0.1),
                  right: BorderSide(width: 0.1),
                  bottom: BorderSide(width: 0.1),
                  
                )
              ),*/
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      itemBuilder: (context){
        return[
          PopupMenuItem<int>(
            padding: EdgeInsets.all(0),
            value: 0, 
            child:Container(width: 0,height: 0,)
            // PopupMenuItemProducto(producto: Producto.copyWith(productos[index]),)
          ),
        ];
      }
    );
  }
}