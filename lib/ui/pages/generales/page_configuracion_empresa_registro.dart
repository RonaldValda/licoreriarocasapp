import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/configuracion_empresa.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_configuracion_empresa.dart';
import 'package:licoreriarocasapp/ui/widgets/textfields.dart';
class PageConfiguracionEmpresaRegistro extends StatefulWidget {
  PageConfiguracionEmpresaRegistro({Key? key,required this.configuracion}) : super(key: key);
  final ConfiguracionEmpresa configuracion;
  @override
  _PageConfiguracionEmpresaRegistroState createState() => _PageConfiguracionEmpresaRegistroState();
}

class _PageConfiguracionEmpresaRegistroState extends State<PageConfiguracionEmpresaRegistro> {
  TextEditingController? controllerMonedaPrincipal;
  TextEditingController? controllerMonedaSecundaria;
  TextEditingController? controllerCambioMoneda;
  TextEditingController? controllerUtilidadMinima;
  TextEditingController? controllerTazaAdicional;
  TextEditingController? controllerMontoVariacionCaja;
  UseCaseConfiguracionEmpresa ucConfiguracion=UseCaseConfiguracionEmpresa();
  @override
  void initState() {
    super.initState();
    controllerMonedaPrincipal=TextEditingController(text:"");
    controllerMonedaSecundaria=TextEditingController(text: "");
    controllerCambioMoneda=TextEditingController(text: "0.0");
    controllerUtilidadMinima=TextEditingController(text: "0.0");
    controllerTazaAdicional=TextEditingController(text: "0.0");
    controllerMontoVariacionCaja=TextEditingController(text: "0.0");
    controllerMonedaPrincipal!.text=widget.configuracion.monedaPrincipal;
    controllerMonedaSecundaria!.text=widget.configuracion.monedaSecundaria;
    controllerCambioMoneda!.text=widget.configuracion.cambioMonedaSecundariaPrincipal.toString();
    controllerUtilidadMinima!.text=widget.configuracion.utilidadMinimaGeneral.toString();
    controllerTazaAdicional!.text=widget.configuracion.tazaAdicionalGeneral.toString();
    controllerMontoVariacionCaja!.text=widget.configuracion.montoMaximoVariacionCaja.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración empresa"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                dragStartBehavior: DragStartBehavior.start,
                
                padding: EdgeInsets.all(10),
                children: [
                  TextFFBasico(
                    controller: controllerMonedaPrincipal!, 
                    labelText: "Moneda principal", 
                    onChanged: (x){
                      widget.configuracion.monedaPrincipal=x;
                    }
                  ),
                  SizedBox(height: 10,),
                  TextFFBasico(
                    controller: controllerMonedaSecundaria!, 
                    labelText: "Moneda secundaria", 
                    onChanged: (x){
                      widget.configuracion.monedaSecundaria=x;
                    }
                  ),
                  SizedBox(height: 10,),
                  TextFFBasico(
                    controller: controllerCambioMoneda!, 
                    labelText: "Cambio de moneda secundaria a principal", 
                    onChanged: (x){
                      widget.configuracion.cambioMonedaSecundariaPrincipal=double.parse(x);
                    }
                  ),
                  SizedBox(height: 10,),
                  TextFFBasico(
                    controller: controllerUtilidadMinima!, 
                    labelText: "Utilidad mínima general", 
                    onChanged: (x){
                      widget.configuracion.utilidadMinimaGeneral=double.parse(x);
                    }
                  ),
                  SizedBox(height: 10,),
                  TextFFBasico(
                    controller: controllerTazaAdicional!, 
                    labelText: "Taza adicional general", 
                    onChanged: (x){
                      widget.configuracion.tazaAdicionalGeneral=double.parse(x);
                      print(x);
                    }
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  SwitchListTile(
                    title: Text("Ordenar categorías alfabéticamente",
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),
                    value: widget.configuracion.ordenarCategoriasAlfabeticamente, 
                    onChanged: (value){
                      widget.configuracion.ordenarCategoriasAlfabeticamente=value;
                      setState(() {
                        
                      });
                    }
                  ),
                  SwitchListTile(
                    title: Text("Ordenar subcategorías alfabéticamente",
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),
                    value: widget.configuracion.ordenarSubcategoriasAlfabeticamente, 
                    onChanged: (value){
                      widget.configuracion.ordenarSubcategoriasAlfabeticamente=value;
                      setState(() {
                        
                      });
                    }
                  ),
                  SwitchListTile(
                    title: Text("Ordenar etiquetas alfabéticamente",
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),
                    value: widget.configuracion.ordenarEtiquetasAlfabeticamente, 
                    onChanged: (value){
                      widget.configuracion.ordenarEtiquetasAlfabeticamente=value;
                      setState(() {
                        
                      });
                    }
                  ),
                  SizedBox(height: 10,),
                  TextFFBasico(
                    controller: controllerMontoVariacionCaja!, 
                    labelText: "Monto máximo de variación de caja", 
                    onChanged: (x){
                      widget.configuracion.montoMaximoVariacionCaja=double.parse(x);
                    }
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: MaterialButton(
                clipBehavior: Clip.antiAlias,
                child: Text(widget.configuracion.id!=""?"Modificar":"Registrar",style: TextStyle(
                  color: Colors.white70,fontSize: 20
                ),),
                onPressed: (){
                  if(widget.configuracion.id==""){
                    widget.configuracion.estado=true;
                    ucConfiguracion.registrarConfiguracionEmpresa(widget.configuracion)
                    .then((resultado) {
                      if(resultado["completado"]){
                        ConfiguracionEmpresa configuracionEmpresa=resultado["configuracion_empresa"];
                        widget.configuracion.id=configuracionEmpresa.id;
                        widget.configuracion.fechaInicio=configuracionEmpresa.fechaInicio;
                        widget.configuracion.fechaFinal=configuracionEmpresa.fechaFinal;
                        Navigator.pop(context);
                      }
                    });
                  }else{
                    ucConfiguracion.modificarConfiguracionEmpresa(widget.configuracion)
                    .then((completado){
                      if(!completado){
                        widget.configuracion.id="";
                      }
                    });
                  }
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}