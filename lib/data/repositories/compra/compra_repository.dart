import 'package:licoreriarocasapp/data/repositories/compra/compra_repository_gql.dart';
import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_compra.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class CompraRepository extends AbstractCompraReposity{
  @override
  Future<Map<String, dynamic>> registrarPreCompra(Compra compra) async{
    Map<String,dynamic> map={};
    bool completado=true;
    Map<String,dynamic> mapVariables={};
    List cpsD=[];
    List compraProductosD=[];
    compra.compraProductos.forEach((cp) { 
      cpsD.add(cp.toMap());
    });
    List<CompraProducto> cps=[];
    mapVariables.addAll(compra.toMap());
    print(compra.toMap());
    mapVariables.addAll({"input_compra_productos":cpsD});
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarPreCompra()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            if(data["registrarPreCompra"]["compra_productos"]!=null){
              compraProductosD=data["registrarPreCompra"]["compra_productos"];
              compraProductosD.forEach((data) {
              CompraProducto cp=CompraProducto.fromMap(data);
                cps.add(cp);
              });
              cps.sort((a,b)=>a.producto.contenido.compareTo(b.producto.contenido));
              for(int i=0;i<compra.compraProductos.length;i++){
                compra.compraProductos[i].id=cps[i].id;
              }
              print(data["registrarPreCompra"]);
              compra.id=data["registrarPreCompra"]["id"];
              compra.fechaPreCompraSistema=data["registrarPreCompra"]["fecha_pre_compra_sistema"];
              compra.fechaPreCompraMovimiento=data["registrarPreCompra"]["fecha_pre_compra_movimiento"];
            }
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["compra"]=compra;
    return map;
  }

  @override
  Future<bool> terminarPreCompra(Compra compra) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationTerminarPreCompra()),
        variables: (
          compra.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    return completado;
  }

  @override
  Future<bool> modificarPreCompra(Compra compra) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarPreCompra()),
        variables: (
          compra.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    return completado;
  }

  @override
  Future<Map<String, dynamic>> obtenerPreComprasPendientes(String idSucursal,String tipoUsuarioConfirmacion) async{
    Map<String,dynamic> map={};
    List<Compra> compras=[];
    List comprasD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerPreComprasPendientes()),
        variables: ({"id_sucursal":idSucursal,"tipo_usuario_confirmacion":tipoUsuarioConfirmacion}),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerPreComprasPendientes"]!=null){
          comprasD=result.data!["obtenerPreComprasPendientes"];
          comprasD.forEach((data) {
            compras.add(Compra.fromMap(data));
          });
      }
    }
    map["completado"]=completado;
    map["compras"]=compras;
    return map;
  }

  @override
  Future<Map<String, dynamic>> responderConfirmacionPreCompra(Compra compra) async{
    Map<String,dynamic> map={};
    bool completado=true;
    Map<String,dynamic> mapVariables={};
    List cpsD=[];
    List compraProductosD=[];
    compra.compraProductos.forEach((cp) { 
      cpsD.add(cp.toMap());
    });
    List<CompraProducto> cps=[];
    mapVariables.addAll(compra.toMap());
    mapVariables.addAll({"input_compra_productos":cpsD});
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationResponderConfirmacionPreCompra()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            
            if(data["responderConfirmacionPreCompra"]!=null){
              compra.fechaConfirmacionSistema=data["responderConfirmacionPreCompra"]["fecha_confirmacion_sistema"];
              compra.fechaConfirmacionMovimiento=data["responderConfirmacionPreCompra"]["fecha_confirmacion_movimiento"];
            }
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["compra"]=compra;
    return map;
  }

}