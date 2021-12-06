import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/generales/sucursal_almacen_repository_gql.dart';
import 'package:licoreriarocasapp/data/repositories/generales/sucursal_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class SucursalAlmacenRepository extends AbstractSucursalAlmacenRepository{
  @override
  Future<bool> eliminarSucursalAlmacen(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarSucursalAlmacen()),
        variables: (
          {"id":id}
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
  Future<bool> modificarSucursalAlmacen(SucursalAlmacen sucursalAlmacen) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarSucursalAlmacen()),
        variables: (
          sucursalAlmacen.toMap()
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
  Future<Map<String, dynamic>> obtenerSucursalAlmacenes(String idSucursal) async{
    Map<String,dynamic> map={};
    List<SucursalAlmacen> sucursalAlmacenes=[];
    List sucursalAlmacenesD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerSucursalAlmacenes()),
        variables: ({
          "id_sucursal":idSucursal
        }),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerSucursalAlmacenes"]!=null){
          sucursalAlmacenesD=result.data!["obtenerSucursalAlmacenes"];
          sucursalAlmacenesD.forEach((data) {
            sucursalAlmacenes.add(SucursalAlmacen.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["sucursal_almacenes"]=sucursalAlmacenes;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarSucursalAlmacen(String idSucursal,SucursalAlmacen sucursalAlmacen) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables={};
    mapVariables.addAll(sucursalAlmacen.toMap());
    mapVariables.addAll({"id_sucursal":idSucursal});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarSucursalAlmacen()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            sucursalAlmacen.id=data["registrarSucursalAlmacen"]["id"];
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["sucursal_almacen"]=sucursalAlmacen;
    return map;
  }

}