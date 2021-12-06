import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/generales/configuracion_empresa_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/configuracion_empresa.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class ConfiguracionEmpresaRepository extends AbstractConfiguracionEmpresaRepository{
  @override
  Future<Map<String, dynamic>> registrarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarConfiguracionEmpresa()),
        variables: (
          configuracionEmpresa.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            configuracionEmpresa.id=data["registrarConfiguracionEmpresa"]["id"];
            configuracionEmpresa.fechaInicio=data["registrarConfiguracionEmpresa"]["fecha_inicio"];
            configuracionEmpresa.fechaFinal=data["registrarConfiguracionEmpresa"]["fecha_final"];
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["configuracion_empresa"]=configuracionEmpresa;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerConfiguracionesEmpresa() async{
    Map<String,dynamic> map={};
    List<ConfiguracionEmpresa> configuracionesEmpresa=[];
    List configuracionesEmpresaD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerConfiguracionesEmpresa()),
        variables: ({}),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerConfiguracionesEmpresa"]!=null){
          configuracionesEmpresaD=result.data!["obtenerConfiguracionesEmpresa"];
          configuracionesEmpresaD.forEach((data) {
            configuracionesEmpresa.add(ConfiguracionEmpresa.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["configuraciones_empresa"]=configuracionesEmpresa;
    return map;
  }

  @override
  Future<bool> eliminarConfiguracionEmpresa(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarConfiguracionEmpresa()),
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
  Future<bool> modificarConfiguracionEmpresa(ConfiguracionEmpresa configuracionEmpresa) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarConfiguracionEmpresa()),
        variables: (
          configuracionEmpresa.toMap()
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
  
}