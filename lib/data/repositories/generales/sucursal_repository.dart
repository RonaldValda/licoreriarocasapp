import 'package:flutter/cupertino.dart';
import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/generales/sucursal_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/sucursal.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class SucursalRepository extends AbstractSucursalRepository{
  @override
  Future<Map<String, dynamic>> registrarSucursal(Sucursal sucursal)async{
    print("llega");
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarSucursal()),
        variables: (
          sucursal.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            sucursal.id=data["registrarSucursal"]["id"];
            sucursal.fechaRegistro=data["registrarSucursal"]["fecha_registro"];
            print("termina");
          }
        },
        onError: (error){
          print(error);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["sucursal"]=sucursal;
    return map;
  } 
  @override
  Future<bool> modificarSucursal(Sucursal sucursal)async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    print(sucursal.toMap());
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarSucursal()),
        variables: (
          sucursal.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          var ms=error!.graphqlErrors;
          completado=false;
          throw ErrorDescription(ms[0].message);
        }
      )
    );
    return completado;
  }
  @override
  Future<bool> eliminarSucursal(String id)async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarSucursal()),
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
  Future<Map<String, dynamic>> obtenerSucursales()async{
    Map<String,dynamic> map={};
    List<Sucursal> sucursales=[];
    List sucursalesD=[];
    bool completado=true;
    print("listando");
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerSucursales()),
        variables: ({}),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
      print("hola");
        if(result.data!["obtenerSucursales"]!=null){
          sucursalesD=result.data!["obtenerSucursales"];
          sucursalesD.forEach((data) {
            sucursales.add(Sucursal.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["sucursales"]=sucursales;
    return map;
  }
}