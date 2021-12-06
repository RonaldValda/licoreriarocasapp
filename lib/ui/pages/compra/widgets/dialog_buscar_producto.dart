import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_compra_producto.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';

Future dialogBuscarProducto(
  BuildContext context,
)async{
  
 return await showDialog(
    barrierLabel: "",
    barrierDismissible: true,
    context: context,
    useRootNavigator: true,
    builder: (BuildContext ctx){
      
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(5),
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: 
              Column(
                children: [
                  Text("Agregar productos",style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            children: [
              ContainerRegistroCompraProductos()
            ],
          );
        }
      );
    }
  ); 
  
}
class ContainerRegistroCompraProductos extends StatefulWidget {
  ContainerRegistroCompraProductos({Key? key}) : super(key: key);

  @override
  _ContainerRegistroCompraProductosState createState() => _ContainerRegistroCompraProductosState();
}

class _ContainerRegistroCompraProductosState extends State<ContainerRegistroCompraProductos> {
  TextEditingController? controller;
  List<Producto> productos=[];
  bool buscado=false;
  UseCaseProducto useCaseProducto=UseCaseProducto();
  UseCaseCompraProducto useCaseCompraProducto=UseCaseCompraProducto();
  Producto producto=Producto.vacio();
  List<CompraProducto> compraProductosb=[];
  DateTime? pickedDate;
  @override
  void initState() {
    pickedDate=DateTime.now();
    controller=TextEditingController(text: "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children:[
                      TextFFBasico(
                        controller: controller!, 
                        labelText: "Contenido", 
                        onChanged: (x){
                        }
                      ),
                    ]
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.search),
                  onPressed: (){
                    buscado=true;
                    compraProductosb=[];
                    useCaseProducto.buscarProductoContenido(controller!.text)
                    .then((resultado){
                      if(resultado["completado"]){
                        productos=resultado["productos"];
                        
                        productos.forEach((p) { 
                          CompraProducto cp=CompraProducto.vacio();
                          cp.producto=Producto.copyWith(p);
                          compraProductosb.add(cp);
                        });
                        if(productos.length==0){
                          setState(() {
                                
                          });
                        }else if(productos.length==1){
                          producto=productos[0];
                          Navigator.pop(context,producto);
                        }else{
                          setState(() {
                                
                          });
                        }
                      }
                    });
                    /*CompraProducto compraProducto=CompraProducto.vacio();
                    compraProducto.producto=productos[0];*/
                    //Navigator.pop(context,true);
                  },
                ),
              )
            ],
          ),
          
          if(productos.length>0)widgetListadoProductos(compraProductosb,compraProvider)
        ],
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
  Widget widgetListadoProductos(List<CompraProducto> compraProductos,CompraProvider compraProvider){
    return Container(
      //color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      height:220,
      child: ListView.builder(
        itemCount: compraProductos.length,
        itemBuilder: (context, index) {
          var cp=compraProductos[index];
          TextEditingController controllerFecha=TextEditingController(text: cp.fechaVencimiento);
          TextEditingController controllerPU=TextEditingController(text:cp.precioUnitario.toString());
          TextEditingController controllerCantidad=TextEditingController(text: cp.cantidad.toString());
          TextEditingController controllerTotal=TextEditingController(text: (cp.precioUnitario*cp.cantidad).toString());
          TextEditingController controllerLote=TextEditingController(text: cp.lote);
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.5,
                  color:Colors.grey
                )
              )
            ),
            child:ListTile(
              title: Text(cp.producto.contenido),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${cp.producto.etiqueta.nombreEtiqueta} -> ${cp.producto.etiqueta.subcategoria.nombreSubcategoria} -> ${cp.producto.etiqueta.subcategoria.categoria.nombreCategoria}"),
                  if(cp.seleccionado)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal:0,
                      vertical: 5
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFFBasico(
                                controller: controllerLote, 
                                labelText: "Lote", 
                                onChanged: (x){
                                  cp.lote=x;
                                }
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: TextFFOnTap(
                                controller: controllerFecha, label: "Fecha vencimiento", 
                                onTap: ()async{
                                  DateTime date=await _pickDate(controllerFecha);
                                  setState(() {
                                    pickedDate=date;
                                    cp.fechaVencimiento="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                                    controllerFecha.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                                  });
                                }
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFFBasico(
                                controller: controllerPU, 
                                labelText: "P. Unitario", 
                                onChanged: (x){
                                  cp.precioUnitario=double.parse(x);
                                  controllerTotal.text=(cp.precioUnitario*cp.cantidad).toString();
                                }
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: TextFFBasico(
                                controller: controllerCantidad, 
                                labelText: "Cantidad", 
                                onChanged: (x){
                                  cp.cantidad=int.parse(x);
                                  controllerTotal.text=(cp.precioUnitario*cp.cantidad).toString();
                                }
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              child: TextFFBasico(
                                controller: controllerTotal, 
                                labelText: "Costo total", 
                                onChanged: (x){
                                  
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.green
                          ),
                          child:MaterialButton(
                            child: Text("Agregar",
                              style: TextStyle(
                                color: Colors.white70
                              ),
                            ),
                            onPressed: (){
                              double costoTotal=cp.cantidad*cp.precioUnitario+compraProvider.compra.costoTotal;
                              useCaseCompraProducto.registrarCompraProducto(compraProvider.compra.id,costoTotal, cp)
                              .then((resultado){
                                if(resultado["completado"]){
                                  compraProvider.addCompraProducto(cp);
                                  compraProductosb.removeWhere((element) => element.producto.id==cp.producto.id);
                                  setState(() {
                                    
                                  });
                                }
                              });
                            }
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
              onTap: (){
                cp.seleccionado=!cp.seleccionado;
                producto=productos[index];
                setState(() {
                  
                });
              },
            ),
          );
        },
      ),
    );
  }
  
}