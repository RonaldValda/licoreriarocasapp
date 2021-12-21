import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto_kardex.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/horizontal_data_table_productos.dart';
import 'package:licoreriarocasapp/ui/pages/producto/widgets/popup_menu_button.dart';
import 'package:licoreriarocasapp/ui/pages/producto_kardex/widgets/horizontal_data_table_producto_kardex.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/provider/generales/categoriasProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productoKardex/productoKardexProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';
class PageProductoKardex extends StatefulWidget {
  PageProductoKardex({Key? key}) : super(key: key);

  @override
  _PageProductoKardexState createState() => _PageProductoKardexState();
}

class _PageProductoKardexState extends State<PageProductoKardex> {
  TextEditingController? controllerFechaInicial;
  TextEditingController? controllerFechaFinal;
  DateTime? pickedDate;
  UseCaseProducto useCaseProducto=UseCaseProducto();
  UseCaseProductoKardex useCaseProductoKardex=UseCaseProductoKardex();
  List<ProductoKardex> productoKardexs=[];
  @override
  void initState() {
    super.initState();
    pickedDate=DateTime.now();
    controllerFechaInicial=TextEditingController(text: "");
    controllerFechaFinal=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final categoriasProvider=Provider.of<CategoriasProvider>(context);
    final productosProvider=Provider.of<ProductosProvider>(context);
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    final productoKardexProvider=Provider.of<ProductoKardexProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kardex de productos"),
      ),
      body: Container(
        child:ListView(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                    child: ListView(
                      padding:EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.horizontal,
                      children: [
                        PopupMenuButtonCategoria(),
                        SizedBox(width: 5,),
                        PopupMenuButtonSubcategoria(),
                        SizedBox(width: 5,),
                        PopupMenuButtonEtiqueta()
                      ],
                    ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(00),
                border: Border.all(style: BorderStyle.solid,color: Colors.black26,width: 1)
              ),
              child: MaterialButton(
                onPressed: ()async{
                  useCaseProducto.obtenerProductos(categoriasProvider.etiqueta.id)
                  .then((resultado) {
                    if(resultado["completado"]){
                      productosProvider.productos=[];
                      productosProvider.productos.addAll(resultado["productos"]);
                      productosProvider.notificar();
                      setState(() {
                        
                      });
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Buscar productos")
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            PopupMenuButtonProducto(),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: TextFFOnTap(
                    controller: controllerFechaInicial!, label: "Desde", 
                    onTap: ()async{
                      DateTime date=await _pickDate(controllerFechaInicial!);
                      setState(() {
                        pickedDate=date;
                        //compraProvider.compraProducto.fechaVencimiento="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                        controllerFechaInicial!.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                      });
                    }
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: TextFFOnTap(
                    controller: controllerFechaFinal!, label: "Hasta", 
                    onTap: ()async{
                      DateTime date=await _pickDate(controllerFechaFinal!);
                      setState(() {
                        pickedDate=date;
                        //compraProvider.compraProducto.fechaVencimiento="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                        controllerFechaFinal!.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                      });
                    }
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(00),
                border: Border.all(style: BorderStyle.solid,color: Colors.black26,width: 1)
              ),
              child: MaterialButton(
                onPressed: ()async{
                  int anioInicial=int.parse(controllerFechaInicial!.text.substring(6,10));
                  int mesInicial=int.parse(controllerFechaInicial!.text.substring(3,5));
                  int diaInicial=int.parse(controllerFechaInicial!.text.substring(0,2));
                  int anioFinal=int.parse(controllerFechaFinal!.text.substring(6,10));
                  int mesFinal=int.parse(controllerFechaFinal!.text.substring(3,5));
                  int diaFinal=int.parse(controllerFechaFinal!.text.substring(0,2));
                  DateTime dtFechaInicial=DateTime(anioInicial,mesInicial,diaInicial);
                  DateTime dtFechaFinal=DateTime(anioFinal,mesFinal,diaFinal);
                  useCaseProductoKardex.obtenerProductoKardexs(usuarioProvider.sucursal.id, productosProvider.producto.id, dtFechaInicial.toUtc().toString(), dtFechaFinal.toUtc().toString())
                  .then((resultado) {
                    if(resultado["completado"]){
                      productoKardexs=resultado["producto_kardexs"];
                      productoKardexs.sort((b,a)=>a.fecha.compareTo(b.fecha));
                      productoKardexProvider.setProductoKardexs(productoKardexs);
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Buscar kardex")
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height>MediaQuery.of(context).size.width?MediaQuery.of(context).size.height-300:MediaQuery.of(context).size.height-100,
              decoration: BoxDecoration(
                border: Border(
                  top:BorderSide(
                    color: Colors.black38,
                    width: 0.5
                  )
                )
              ),
              child: HorizontalDataTableProductoKardex()
            )
          ],
        )
      ),
    );
  }
  Future<DateTime> _pickDate(TextEditingController controller) async{
    DateTime? date=await showDatePicker(
      context: context, 
      initialDate: pickedDate!, 
      firstDate: DateTime(DateTime.now().year-5), 
      lastDate: DateTime(DateTime.now().year+5),
      confirmText: "Ok",
      cancelText: "Cancelar",
      //fieldHintText: "Seleccionar fecha",
      //locale: Locale('fr','CH')
      //locale : const Locale("fr","FR")
    ); 
    
    return date!;
  }
  
}