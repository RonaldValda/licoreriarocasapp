import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/ui/pages/compra/widgets/dialog_compra_producto_carrito.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class HorizontalDataTableCompraProductos extends StatefulWidget {
  HorizontalDataTableCompraProductos({Key? key}) : super(key: key);

  @override
  _HorizontalDataTableCompraProductosState createState() => _HorizontalDataTableCompraProductosState();
}

class _HorizontalDataTableCompraProductosState extends State<HorizontalDataTableCompraProductos> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  List<CompraProducto> compraProductos=[];
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    compraProductos=compraProvider.compraCarrito.compraProductos;
    return Container(
      child: HorizontalDataTable(
        
        leftHandSideColumnWidth:150,
        rightHandSideColumnWidth: 460,
        isFixedHeader: true,
        headerWidgets: _getHeaderTable(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: (context, index) {
          return _rowRight(compraProvider,index);
        },
        itemCount: compraProductos.length,
        
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
  List<Widget> _getHeaderTable() {
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
      _getHeaderItem('Lote', 100),
      _getHeaderItem('Fecha vencimiento', 120),
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
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Row(
      children: [
        SizedBox(width: 5,),
        rowItem(
          compraProductos[index].producto.contenido, 135, Alignment.centerLeft,index
        ),
      ],
    );
  }
  Widget _rowRight(CompraProvider compraProvider,index){
    TextEditingController controllerPrecioUnitario=TextEditingController(text: compraProductos[index].precioUnitario.toString());
    TextEditingController controllerTotal=TextEditingController(text: (compraProductos[index].cantidad*compraProductos[index].precioUnitario).toString());
    return Row(
      children: <Widget>[
        rowItem(
          compraProductos[index].lote, 100, Alignment.center,index
        ),
        rowItem(
          compraProductos[index].fechaVencimiento, 120, Alignment.center,index
        ),
        rowItem(
          compraProductos[index].precioUnitario.toString(), 80, Alignment.center,index
        ),
        rowItem(
          compraProductos[index].cantidad.toString(), 80, Alignment.center,index
        ),
        rowItem(
          (compraProductos[index].cantidad*compraProductos[index].precioUnitario).toString(), 80, Alignment.center,index
        ),
      ],
    );
  }
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    TextEditingController controllerPrecioUnitario=TextEditingController(text: compraProductos[index].precioUnitario.toString());
    TextEditingController controllerTotal=TextEditingController(text: (compraProductos[index].cantidad*compraProductos[index].precioUnitario).toString());
    return Row(
      children: <Widget>[
        rowItem(
          compraProductos[index].lote, 100, Alignment.center,index
        ),
        rowItem(
          compraProductos[index].fechaVencimiento, 120, Alignment.center,index
        ),
        
        Container(
          width: 80,
          height: 32,
          child: TextFFLimpio(
            controller: controllerPrecioUnitario,
            onChanged: (x){
              compraProductos[index].precioUnitario=double.parse(x);
              controllerTotal.text=(compraProductos[index].precioUnitario*compraProductos[index].cantidad).toString();
            },
            textAlign: TextAlign.center,
          ),
        ),
        rowItem(
          compraProductos[index].cantidad.toString(), 80, Alignment.center,index
        ),
        Container(
          width: 80,
          height: 32,
          child: TextFFLimpio(
            isEnabled: false,
            controller: controllerTotal,
            onChanged: (x){
            },
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
  Widget rowItem(String texto,double width,AlignmentGeometry alignment,int index){
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
            child:PopupMenuItemCompraProducto(compraProducto: compraProductos[index],)
            // PopupMenuItemProducto(producto: Producto.copyWith(productos[index]),)
          ),
        ];
      }
    );
  }
}
class PopupMenuItemCompraProducto extends StatefulWidget {
  PopupMenuItemCompraProducto({Key? key,required this.compraProducto}) : super(key: key);
  final CompraProducto compraProducto;
  @override
  _PopupMenuItemCompraProductoState createState() => _PopupMenuItemCompraProductoState();
}

class _PopupMenuItemCompraProductoState extends State<PopupMenuItemCompraProducto> {
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Modificar"),
            onTap: ()async{
              compraProvider.compraProducto=widget.compraProducto;
              await dialogCompraProductoCarrito(context);
              compraProvider.setCostoTotalCarrito(compraProvider.compraCarrito.compraProductos);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Eliminar"),
            onTap: ()async{
              /*useCaseProducto.eliminarProducto(widget.producto)
              .then((completado){
                productosProvider.productos.removeWhere((element) => element.id==widget.producto.id);
                productosProvider.notificar();
              });
              Navigator.pop(context);*/
            },
          ),
        ],
      ),
    );
  }
}