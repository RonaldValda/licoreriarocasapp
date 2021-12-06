import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/generales/etiqueta_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class EtiquetaRepository extends AbstractEtiquetaRepository{
  @override
  Future<bool> eliminarEtiqueta(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarEtiqueta()),
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
  Future<bool> modificarEtiqueta(Etiqueta etiqueta) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarEtiqueta()),
        variables: (
          etiqueta.toMap()
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
  Future<Map<String, dynamic>> registrarEtiqueta(String idSubcategoria, Etiqueta etiqueta) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables={};
    mapVariables.addAll(etiqueta.toMap());
    mapVariables.addAll({"id_subcategoria":idSubcategoria});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarEtiqueta()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            etiqueta.id=data["registrarEtiqueta"]["id"];
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["etiqueta"]=etiqueta;
    return map;
  }

}