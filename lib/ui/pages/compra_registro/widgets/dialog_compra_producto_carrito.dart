import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/usecases/compra/usecase_compra_producto.dart';
import 'package:licoreriarocasapp/domain/usecases/producto/usecase_producto.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
import 'package:provider/provider.dart';

Future dialogCompraProductoCarrito(
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
            //insetPadding: EdgeInsets.all(5),
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            children: [
              ContainerProductoCompraCarrito()
            ],
          );
        }
      );
    }
  ); 
  
}
class ContainerProductoCompraCarrito extends StatefulWidget {
  ContainerProductoCompraCarrito({Key? key}) : super(key: key);

  @override
  _ContainerProductoCompraCarritoState createState() => _ContainerProductoCompraCarritoState();
}

class _ContainerProductoCompraCarritoState extends State<ContainerProductoCompraCarrito> {
  TextEditingController? controller;
  List<Producto> productos=[];
  bool buscado=false;
  UseCaseProducto useCaseProducto=UseCaseProducto();
  UseCaseCompraProducto useCaseCompraProducto=UseCaseCompraProducto();
  Producto producto=Producto.vacio();
  List<CompraProducto> compraProductosb=[];
  DateTime? pickedDate;
  TextEditingController? controllerFecha;
  TextEditingController? controllerPU;
  TextEditingController? controllerCantidad;
  TextEditingController? controllerTotal;
  TextEditingController? controllerLote;
  late CompraProvider cmpProvider;
  @override
  void initState() {
    pickedDate=DateTime.now();
    controllerFecha=TextEditingController(text: "");
    controllerPU=TextEditingController(text:"");
    controllerCantidad=TextEditingController(text: "");
    controllerTotal=TextEditingController(text: "");
    controllerLote=TextEditingController(text: "");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      cmpProvider=Provider.of<CompraProvider>(context,listen: false);
      controller=TextEditingController(text: "");
      controllerFecha=TextEditingController(text: cmpProvider.compraProducto.fechaVencimiento);
      controllerPU=TextEditingController(text:cmpProvider.compraProducto.precioUnitario.toString());
      controllerCantidad=TextEditingController(text: cmpProvider.compraProducto.cantidad.toString());
      controllerTotal=TextEditingController(text: (cmpProvider.compraProducto.precioUnitario*cmpProvider.compraProducto.cantidad).toString());
      controllerLote=TextEditingController(text: cmpProvider.compraProducto.lote);
      setState(() {
        
      });
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final compraProvider=Provider.of<CompraProvider>(context);
    final usuarioProvider=Provider.of<UsuarioProvider>(context);
    //print("usuario Precompra ${compraProvider.compraCarrito.usuarioPreCompra.id}");
    //print("usuario Provider ${usuarioProvider.usuario.id}");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: usuarioProvider.usuario.tipoUsuario=="Vendedor"?250:350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal:10,
              vertical: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFFBasico(
                  controller: controllerLote!,
                  labelText: "Lote", 
                  onChanged: (x){
                    compraProvider.compraProducto.lote=x;
                  }
                ),
                SizedBox(height: 5,),
                TextFFOnTap(
                  controller: controllerFecha!, label: "Fecha vencimiento", 
                  onTap: ()async{
                    DateTime date=await _pickDate(controllerFecha!);
                    setState(() {
                      pickedDate=date;
                      compraProvider.compraProducto.fechaVencimiento="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                      controllerFecha!.text="${pickedDate!.day.toString().padLeft(2,'0')}-${pickedDate!.month.toString().padLeft(2,'0')}-${pickedDate!.year.toString()}";
                    });
                  }
                ),
                SizedBox(height: 5,),
                if(usuarioProvider.usuario.tipoUsuario!="Vendedor")
                TextFFBasico(
                  controller: controllerPU!, 
                  //isEnabled: compraProvider.compraCarrito.usuarioPreCompra.id==usuarioProvider.usuario.id,
                  labelText: "P. Unitario", 
                  onChanged: (x){
                    compraProvider.compraProducto.precioUnitario=double.parse(x);
                    controllerTotal!.text=(compraProvider.compraProducto.precioUnitario*compraProvider.compraProducto.cantidad).toString();
                  }
                ),
                SizedBox(height: 5,),
                TextFFBasico(
                  //isEnabled: compraProvider.compraCarrito.usuarioPreCompra.id==usuarioProvider.usuario.id,
                  controller: controllerCantidad!, 
                  labelText: "Cantidad", 
                  onChanged: (x){
                    compraProvider.compraProducto.cantidad=int.parse(x);
                    controllerTotal!.text=(compraProvider.compraProducto.precioUnitario*compraProvider.compraProducto.cantidad).toString();
                  }
                ),
                SizedBox(height: 5,),
                if(usuarioProvider.usuario.tipoUsuario!="Vendedor")
                TextFFBasico(
                  isEnabled: false,
                  controller: controllerTotal!, 
                  labelText: "Costo total", 
                  onChanged: (x){
                    
                  }
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              ),
              color: Colors.redAccent
            ),
            child:MaterialButton(
              child: Text("Cerrar",
                style: TextStyle(
                  color: Colors.white70
                ),
              ),
              onPressed: (){
                Navigator.pop(context);
              }
            )
          )
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
  
}