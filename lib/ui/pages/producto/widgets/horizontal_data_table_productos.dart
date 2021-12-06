import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/popup_menu_item.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:provider/provider.dart';
class HorizontalDataTableProductos extends StatefulWidget {
  HorizontalDataTableProductos({Key? key}) : super(key: key);

  @override
  _HorizontalDataTableProductosState createState() => _HorizontalDataTableProductosState();
}

class _HorizontalDataTableProductosState extends State<HorizontalDataTableProductos> {
  static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  List<Producto> productos=[];
  @override
  Widget build(BuildContext context) {
    final productosProvider=Provider.of<ProductosProvider>(context);
    productos=[];
    productos.addAll(productosProvider.productos);
    return Container(
      child: HorizontalDataTable(
        
        leftHandSideColumnWidth:150,
        rightHandSideColumnWidth: 700,
        isFixedHeader: true,
        headerWidgets: _getHeaderTable(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: productosProvider.productos.length,
        
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
      _getHeaderItem('Código (Barras QR)', 150),
      _getHeaderItem('Unidad', 150),
      _getHeaderItem('Precio', 80),
      _getHeaderItem('Stock mínimo', 80),
      _getHeaderItem('Utilidad', 80),
      _getHeaderItem('Venc. máximo', 80),
      _getHeaderItem('° alcohólico', 80),
    ];
  }
  Widget _getHeaderItem(String label, double width) {
    return Container(
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: [
          Center(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
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
          productos[index].contenido, 145, Alignment.centerLeft,index
        ),
      ],
    );
  }
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        rowItem(
          productos[index].codigo, 150, Alignment.centerLeft,index
        ),
        rowItem(
          productos[index].unidad, 150, Alignment.center,index
        ),
        rowItem(
          productos[index].precio.toString(), 80, Alignment.center,index
        ),
        rowItem(
          productos[index].stockMinimo.toString(), 80, Alignment.center,index
        ),
        rowItem(
          productos[index].utilidad.toString(), 80, Alignment.center,index
        ),
        rowItem(
          productos[index].vencimientoMaximo.toString(), 80, Alignment.center,index
        ),
        rowItem(
          productos[index].gradoAlcoholico.toString(), 80, Alignment.center,index
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
                  textAlign: TextAlign.right,
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
            child: PopupMenuItemProducto(producto: Producto.copyWith(productos[index]),)
          ),
        ];
      }
    );
  }
}