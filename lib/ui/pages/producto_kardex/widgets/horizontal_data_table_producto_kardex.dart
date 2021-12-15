import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/ui/provider/productoKardex/productoKardexProvider.dart';
import 'package:provider/provider.dart';
class HorizontalDataTableProductoKardex extends StatefulWidget {
  HorizontalDataTableProductoKardex({Key? key}) : super(key: key);

  @override
  _HorizontalDataTableProductoKardexState createState() => _HorizontalDataTableProductoKardexState();
}

class _HorizontalDataTableProductoKardexState extends State<HorizontalDataTableProductoKardex> {
   static const int sortName = 0;
  static const int sortStatus = 1;
  bool isAscending = true;
  int sortType = sortName;
  Map<String,dynamic> mapColores={
    "Entrada":Colors.green.withOpacity(0.1)
  };
  @override
  Widget build(BuildContext context) {
    final productoKardexProvider=Provider.of<ProductoKardexProvider>(context);
    return Container(
      child: HorizontalDataTable(
        
        leftHandSideColumnWidth:120,
        rightHandSideColumnWidth: 780,
        isFixedHeader: true,
        headerWidgets: _getHeaderTable(),
        leftSideItemBuilder: (context, index) {
          return _generateFirstColumnRow(context,index,productoKardexProvider);
        },
        rightSideItemBuilder: (context, index) {
          return _generateRightHandSideColumnRow(context,index,productoKardexProvider);
        },
        itemCount: productoKardexProvider.productoKardexs.length,
        
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
          _getHeaderItem('Fecha',120),
        ],
      ),
      _getHeaderItem('Detalle',120),
      _getHeaderItem('Nro Comprobante', 100),
      _getHeaderItem('Valor Unitario', 80),
      _getHeaderItem('Cantidad entrada', 80),
      _getHeaderItem('Valor entrada', 80),
      _getHeaderItem('Cantidad salida', 80),
      _getHeaderItem('Valor salida', 80),
      _getHeaderItem('Cantidad saldo', 80),
      _getHeaderItem('Valor saldo', 80),
    ];
  }
  Widget _getHeaderItem(String label, double width) {
    return Container(
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        children: [
          Center(
            child: Text(
              label, 
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center
            )
          ),
        ],
      ),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }
  Widget _generateFirstColumnRow(BuildContext context, int index,ProductoKardexProvider productoKardexProvider){
    ProductoKardex productoKardex=productoKardexProvider.productoKardexs[index];
    DateTime dtFecha=DateTime.parse(productoKardex.fecha).toLocal();
    String dia=dtFecha.day<10?"0"+dtFecha.day.toString():dtFecha.day.toString();
    String mes=dtFecha.month<10?"0"+dtFecha.month.toString():dtFecha.month.toString();
    String hora=dtFecha.hour<10?"0"+dtFecha.hour.toString():dtFecha.hour.toString();
    String minutos=dtFecha.minute<10?"0"+dtFecha.minute.toString():dtFecha.minute.toString();
    String fecha="  $dia-$mes-${dtFecha.year} $hora:$minutos";
    return Row(
      children: [
        rowItem(
          fecha, 120, Alignment.centerLeft,TextAlign.left,index,color: mapColores[productoKardex.tipo]
        ),
      ],
    );
  }
  Widget _generateRightHandSideColumnRow(BuildContext context, int index,ProductoKardexProvider productoKardexProvider){
    ProductoKardex productoKardex=productoKardexProvider.productoKardexs[index];
    return Row(
      children: <Widget>[
        rowItem(
          productoKardex.detalle, 120, Alignment.centerLeft,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.nroComprobante, 100, Alignment.centerLeft,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.valorUnitario.toString(), 80, Alignment.center,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.tipo=="Entrada"?productoKardex.cantidad.toString():"0", 80, Alignment.center,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.tipo=="Entrada"?productoKardex.valor.toString():"0", 80, Alignment.center,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.tipo=="Salida"?productoKardex.cantidad.toString():"0", 80, Alignment.center,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.tipo=="Salida"?productoKardex.valor.toString():"0", 80, Alignment.center,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.cantidadSaldo.toString(), 80, Alignment.center,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
        rowItem(
          productoKardex.valorSaldo.toString(), 80, Alignment.center,TextAlign.center,index,color: mapColores[productoKardex.tipo]
        ),
      ],
    );
  }
  Widget rowItem(String texto,double width,AlignmentGeometry alignment,TextAlign textAlign,int index,{Color color:Colors.transparent}){
    return Container(
      color: color,
      child: Row(
        children: [
          Container(
            alignment: alignment,
            height:32,
            child:Container(
              alignment: alignment,
              width: width,
              child: Text(texto,
                textAlign: textAlign,
                style:TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}