import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/generales/subcategoria_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class SubcategoriasRepository extends AbstractSubcategoriaRepository{
  @override
  Future<bool> eliminarSubcategoria(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutatioEliminarSubcategoria()),
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
  Future<bool> modificarSubcategoria(Subcategoria subcategoria)async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarSubcategoria()),
        variables: (
          subcategoria.toMap()
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
  Future<Map<String, dynamic>> obtenerSubcategoria(Categoria categoria) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> registrarSubcategoria(String idCategoria, Subcategoria subcategoria)async{
    print("object");
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables={};
    mapVariables.addAll(subcategoria.toMap());
    mapVariables.addAll({"id_categoria":idCategoria});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarSubcategoria()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            subcategoria.id=data["registrarSubcategoria"]["id"];
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["subcategoria"]=subcategoria;
    return map;
  }
} 