import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/entities/producto_oferta_dia.dart';
import 'package:licoreriarocasapp/domain/usecases/venta/usecase_producto_oferta_dia.dart';
import 'package:licoreriarocasapp/ui/utils/generales_utils.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
Future dialogProductoOfertaDia(
  BuildContext context,
  Producto producto
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
                  Text("Oferta del día",style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            children: [
              ContainerProductoOfertaDia(producto:producto),
            ],
          );
        }
      );
    }
  ); 
}
class ContainerProductoOfertaDia extends StatefulWidget {
  ContainerProductoOfertaDia({Key? key,required this.producto}) : super(key: key);
  final Producto producto;
  @override
  _ContainerProductoOfertaDiaState createState() => _ContainerProductoOfertaDiaState();
}

class _ContainerProductoOfertaDiaState extends State<ContainerProductoOfertaDia> {
  DateTime pickedDate=DateTime.now();
  ProductoOfertaDia productoOfertaDia=ProductoOfertaDia.vacio();
  UseCaseProductoOfertaDia useCaseProductoOfertaDia=UseCaseProductoOfertaDia();
  TextEditingController? controllerFecha;
  TextEditingController? controllerPrecioUnitario;
  DateTime dtFecha=DateTime.now();
  @override
  void initState() {
    super.initState();
    dtFecha=DateTime(pickedDate.year,pickedDate.month,pickedDate.day);
    controllerFecha=TextEditingController(text: "${pickedDate.day.toString().padLeft(2,'0')}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.year.toString()}");
    controllerPrecioUnitario=TextEditingController(text: "0.0");
    useCaseProductoOfertaDia.obtenerProductoOfertaDia(widget.producto.id, dtFecha.toUtc().toString())
    .then((resultado){
        if(resultado["completado"]){
          productoOfertaDia=resultado["producto_oferta_dia"];
          controllerPrecioUnitario!.text=productoOfertaDia.precioUnitario.toString();
          setState(() {
            
          });
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.6,
      height:MediaQuery.of(context).size.height/1.5,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(5),
              children: [
                Text(productoOfertaDia.id==""?"Sin oferta":"Con oferta"),
                SizedBox(height: 5,),
                TextFFOnTap(
                  controller: controllerFecha!, 
                  label: "Fecha", 
                  onTap: ()async{
                    try{
                      DateTime firstDate= DateTime(DateTime.now().year-1);
                      DateTime lastDate= DateTime(DateTime.now().year+1);
                      pickedDate=await pickDate(context,pickedDate,firstDate,lastDate);
                      //setState(() {
                        controllerFecha!.text="${pickedDate.day.toString().padLeft(2,'0')}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.year.toString()}";
                      //});
                      dtFecha=DateTime(pickedDate.year,pickedDate.month,pickedDate.day);
                      useCaseProductoOfertaDia.obtenerProductoOfertaDia(widget.producto.id, dtFecha.toUtc().toString())
                      .then((resultado){
                          if(resultado["completado"]){
                            productoOfertaDia=resultado["producto_oferta_dia"];
                            controllerPrecioUnitario!.text=productoOfertaDia.precioUnitario.toString();
                            setState(() {
                              
                            });
                          }
                      });
                    }catch(e){

                    }
                  },
                ),
                SizedBox(height: 5,),
                TextFFBasico(
                  controller: controllerPrecioUnitario!, 
                  labelText: "Precio unitario", 
                  onChanged: (x){
                    productoOfertaDia.precioUnitario=double.parse(x);
                  }
                ),
                SwitchListTile(
                  title: Text("Solo tienda"),
                  value: productoOfertaDia.soloTienda, 
                  onChanged: (value){
                    setState(() {
                      productoOfertaDia.soloTienda=value;
                    });
                  }
                ),
                SwitchListTile(
                  title: Text("Solo app"),
                  value: productoOfertaDia.soloApp, 
                  onChanged: (value){
                    setState(() {
                      productoOfertaDia.soloApp=value;
                    });
                  }
                ),
                SwitchListTile(
                  title: Text("En tienda y app"),
                  value: productoOfertaDia.tiendaApp, 
                  onChanged: (value){
                    setState(() {
                      productoOfertaDia.tiendaApp=value;
                    });
                  }
                ),
                SwitchListTile(
                  title: Text("Oferta activa"),
                  value: productoOfertaDia.activo, 
                  onChanged: (value){
                    setState(() {
                      productoOfertaDia.activo=value;
                    });
                  }
                ),
              ],
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.orange.shade900,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)
              )
            ),
            child: MaterialButton(
              child: Text(productoOfertaDia.id==""?"Registrar":"Modificar",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70
                ),
              ),
              onPressed: (){
                if(productoOfertaDia.id==""){
                  productoOfertaDia.producto=widget.producto;
                  productoOfertaDia.fecha=dtFecha.toUtc().toString();
                  useCaseProductoOfertaDia.registrarProductoOfertaDia(productoOfertaDia)
                  .then((resultado){
                    if(resultado["completado"]){
                    }else{
                      print(resultado["mensaje_error"]);
                    }
                  });
                }
                //Navigator.pop(context,true);
              }
            ),
          )
        ],
      ),
    );
  }
}