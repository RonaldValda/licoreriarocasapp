import 'package:flutter/material.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_categoria.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_etiqueta.dart';
import 'package:licoreriarocasapp/domain/usecases/generales/usecase_subcategoria.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/buttons.dart';
import 'package:licoreriarocasapp/ui/pages/generales/widgets/dialog_registro_categoria.dart';
class PageCategorias extends StatefulWidget {
  PageCategorias({Key? key}) : super(key: key);

  @override
  _PageCategoriasState createState() => _PageCategoriasState();
}

class _PageCategoriasState extends State<PageCategorias> {
  List<Categoria> categorias=[];
  UseCaseCategoria ucCategoria=UseCaseCategoria();
  UseCaseSubcategoria ucSubcategoria=UseCaseSubcategoria();
  UseCaseEtiqueta ucEtiqueta=UseCaseEtiqueta();
  Categoria categoriaSel=Categoria.vacio();
  @override
  void initState() {
    super.initState();
    ucCategoria.obtenerCategorias()
    .then((resultado){
      if(resultado["completado"]){
        categorias=resultado["categorias"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    categorias.sort((a,b)=>a.nombreCategoria.compareTo(b.nombreCategoria));
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            List<String> cs=["1","2","3","4","5","6","7"];
            ucCategoria.registrarMuchasCategorias(cs)
            .then((value) {
              
            });
          }, icon: Icon(Icons.one_k))
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back,color: Colors.black87,)
        ),
        title: Wrap(
          children: [
            Text("Categorías",style: TextStyle(color: Colors.black87)),
          ],
        ),
        
      ),
      body: Container(
        child: ListView.builder(
          itemCount: categorias.length,
          itemBuilder: (context, index) {
            var categoria=categorias[index];
            return widgetCategoria(categoria);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Agregar categoría",
        child: Icon(Icons.add,size: 30,),
        onPressed:()async{
          try{
            bool respuesta=await dialogRegistroCategoria(context, categoriaSel,Subcategoria.vacio(),Etiqueta.vacio(),getOpcionCategoria.categoria.index,getOpcionOperacion.registrar.index);
            if(respuesta){
              ucCategoria.registrarCategoria(categoriaSel)
              .then((resultado){
                if(resultado["completado"]){
                  categoriaSel=resultado["categoria"];
                  categorias.add(categoriaSel);
                  categorias.sort((a,b)=>a.nombreCategoria.compareTo(b.nombreCategoria));
                  categoriaSel=Categoria.vacio();
                  setState(() {
                    
                  });
                }
              });
            }
          }catch(exception){
            print(exception);
          }
        }
      ),
    );
  }
  Widget widgetEtiquetas(List<Etiqueta> etiquetas){
    etiquetas.sort((a,b)=>a.nombreEtiqueta.compareTo(b.nombreEtiqueta));
    return Container(
      padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: etiquetas.map((e){
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.nombreEtiqueta,style: TextStyle(color: Colors.black87)),
                  if(e.seleccionado)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonChip(
                          text: "Modificar", 
                          fontSize: 13,
                          size: Size(60,25), 
                          colorText: Colors.white70, 
                          colorButton: Colors.blue.shade900, 
                          onPressed: ()async{
                            try{
                              Etiqueta et=Etiqueta.copyWith(e);
                              bool respuesta=await dialogRegistroCategoria(context, Categoria.vacio(),Subcategoria.vacio(),et,getOpcionCategoria.etiqueta.index,getOpcionOperacion.modificar.index);
                              if(respuesta){
                                ucEtiqueta.modificarEtiqueta(et)
                                .then((completado){
                                  if(completado){
                                    etiquetas.removeWhere((element) => element.id==et.id);
                                    etiquetas.add(et);
                                    et.seleccionado=true;
                                    setState(() {
                                      
                                    });
                                  }
                                });
                              }
                            }catch(exception){
                              print(exception);
                            }
                          }
                        ),
                        SizedBox(width: 2,),
                        ButtonChip(
                          text: "Eliminar", 
                          fontSize: 13,
                          size: Size(60,25), 
                          colorText: Colors.white70, 
                          colorButton: Colors.red.shade900, 
                          onPressed: ()async{
                            ucEtiqueta.eliminarEtiqueta(e)
                            .then((completado){
                              if(completado){
                                etiquetas.removeWhere((element) => element.id==e.id);
                                setState(() {
                                  
                                });
                              }
                            });
                          }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: Icon(!e.seleccionado?Icons.keyboard_arrow_right:Icons.keyboard_arrow_down,size: 30,),
              onTap: (){
                setState(() {
                  e.seleccionado=!e.seleccionado;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
  Widget widgetSubcategorias(List<Subcategoria> subcategorias){
    subcategorias.sort((a,b)=>a.nombreSubcategoria.compareTo(b.nombreSubcategoria));
    return Container(
      padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 2,
            ),
          ),
        ),
        child: Column(
          children:subcategorias.map((sc){
            return Column(
              children: [
                ListTile(
                  title: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sc.nombreSubcategoria,style: TextStyle(color: Colors.black87)),
                      if(sc.seleccionado)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ButtonChip(
                              text: "Agregar etiqueta", 
                              fontSize: 13,
                              size: Size(110,25), 
                              colorText: Colors.white70, 
                              colorButton: Colors.blue.shade700, 
                              onPressed: ()async{
                                try{
                                  Etiqueta etiqueta=Etiqueta.vacio();
                                  bool respuesta=await dialogRegistroCategoria(context, Categoria.vacio(),Subcategoria.vacio(),etiqueta,getOpcionCategoria.etiqueta.index,getOpcionOperacion.registrar.index);
                                  if(respuesta){
                                    ucEtiqueta.registrarEtiqueta(sc.id, etiqueta)
                                    .then((resultado){
                                      if(resultado["completado"]){
                                        etiqueta=resultado["etiqueta"];
                                        sc.etiquetas.add(etiqueta);
                                        setState(() {
                                          
                                        });
                                      }
                                    });
                                  }
                                }catch(exception){
                                  print(exception);
                                }
                              },
                            ),
                            SizedBox(width: 2,),
                            ButtonChip(
                              text: "Modificar", 
                              fontSize: 13,
                              size: Size(60,25), 
                              colorText: Colors.white70, 
                              colorButton: Colors.blue.shade700, 
                              onPressed: ()async{
                                try{
                                  Subcategoria subcat=Subcategoria.copyWith(sc);
                                  bool respuesta=await dialogRegistroCategoria(context, Categoria.vacio(),subcat,Etiqueta.vacio(),getOpcionCategoria.subcategoria.index,getOpcionOperacion.modificar.index);
                                  if(respuesta){
                                    ucSubcategoria.modificarSubcategoria(subcat)
                                    .then((completado){
                                      if(completado){
                                        subcategorias.removeWhere((element) => element.id==subcat.id);
                                        subcat.seleccionado=true;
                                        subcategorias.add(subcat);
                                        setState(() {
                                          
                                        });
                                      }
                                    });
                                  }
                                }catch(exception){
                                  print(exception);
                                }
                              }
                            ),
                            SizedBox(width: 2,),
                            ButtonChip(
                              text: "Eliminar", 
                              fontSize: 13,
                              size: Size(60,25), 
                              colorText: Colors.white70, 
                              colorButton: Colors.red.shade700, 
                              onPressed: ()async{
                                if(sc.etiquetas.length==0){
                                  ucSubcategoria.eliminarSubcategoria(sc)
                                  .then((completado){
                                    if(completado){
                                      subcategorias.removeWhere((element) => element.id==sc.id);
                                      setState(() {
                                        
                                      });
                                    }
                                  });
                                }
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(!sc.seleccionado?Icons.keyboard_arrow_right:Icons.keyboard_arrow_down,size: 30,),
                  onTap: (){
                    setState(() {
                      sc.seleccionado=!sc.seleccionado;
                    });
                  },
                ),
                if(sc.seleccionado)
                widgetEtiquetas(sc.etiquetas)
              ],
            );
          }).toList()
        ),
      ),
    );
  }
  Widget widgetCategoria(Categoria categoria){
    return Column(
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categoria.nombreCategoria,style: TextStyle(color: Colors.black87),),
              if(categoria.seleccionado)
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonChip(
                      text: "Agregar subcategoria", 
                      fontSize: 13,
                      size: Size(130,25), 
                      colorText: Colors.white70, 
                      colorButton: Colors.blue, 
                      onPressed: ()async{
                        try{
                          Subcategoria subcategoria=Subcategoria.vacio();
                          bool respuesta=await dialogRegistroCategoria(context, Categoria.vacio(),subcategoria,Etiqueta.vacio(),getOpcionCategoria.subcategoria.index,getOpcionOperacion.registrar.index);
                          if(respuesta){
                            ucSubcategoria.registrarSubcategoria(categoria.id,subcategoria)
                            .then((resultado){
                              if(resultado["completado"]){
                                subcategoria=resultado["subcategoria"];
                                categoria.subcategorias.add(subcategoria);
                                setState(() {
                                  
                                });
                              }
                            });
                          }
                        }catch(exception){
                          print(exception);
                        }
                      },
                    ),
                    SizedBox(width: 2,),
                    ButtonChip(
                      text: "Modificar", 
                      fontSize: 13,
                      size: Size(60,25), 
                      colorText: Colors.white70, 
                      colorButton: Colors.blue, 
                      onPressed: ()async{
                        try{
                          Categoria cat=Categoria.copyWith(categoria);
                          bool respuesta=await dialogRegistroCategoria(context, cat,Subcategoria.vacio(),Etiqueta.vacio(),getOpcionCategoria.categoria.index,getOpcionOperacion.modificar.index);
                          if(respuesta){
                            ucCategoria.modificarCategoria(cat)
                            .then((completado){
                              if(completado){
                                categorias.removeWhere((element) => element.id==cat.id);
                                cat.seleccionado=true;
                                categorias.add(cat);
                                setState(() {
                                  
                                });
                              }
                            });
                          }
                        }catch(exception){
                          print(exception);
                        }
                      },
                    ),
                    SizedBox(width: 2,),
                    ButtonChip(
                      text: "Eliminar", 
                      fontSize: 13,
                      size: Size(60,25), 
                      colorText: Colors.white70, 
                      colorButton: Colors.red, 
                      onPressed: ()async{
                        if(categoria.subcategorias.length==0){
                          ucCategoria.eliminarCategoria(categoria)
                          .then((completado){
                            categorias.removeWhere((element) => element.id==categoria.id);
                            setState(() {
                              
                            });
                          });
                        }
                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Icon(!categoria.seleccionado?Icons.keyboard_arrow_right:Icons.keyboard_arrow_down,size: 30,),
          onTap: (){
            setState(() {
              categoria.seleccionado=!categoria.seleccionado;
            });
          },
        ),
        if(categoria.seleccionado)
        widgetSubcategorias(categoria.subcategorias),
        Container(
          width: MediaQuery.of(context).size.width,
          height:0.5,
          color: Colors.grey,
        )
      ],
    );
  }
}