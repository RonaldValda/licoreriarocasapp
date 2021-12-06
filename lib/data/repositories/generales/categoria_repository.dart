import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/generales/categoria_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/categoria.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_generales.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class CategoriaRepository extends AbstractCategoriaRepository{
  @override
  Future<Map<String, dynamic>> registrarCategoria(Categoria categoria) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarCategoria()),
        variables: (
          categoria.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            categoria.id=data["registrarCategoria"]["id"];
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["categoria"]=categoria;
    return map;
  }
  
  @override
  Future<bool> modificarCategoria(Categoria categoria) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarCategoria()),
        variables: (
          categoria.toMap()
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
  Future<bool> eliminarCategoria(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarCategoria()),
        variables: (
          {"id":id}
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    return completado;
  }

  @override
  Future<Map<String, dynamic>> obtenerCategorias() async{
    Map<String,dynamic> map={};
    List<Categoria> categorias=[];
    List categoriasD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerCategorias()),
        variables: ({}),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerCategorias"]!=null){
          categoriasD=result.data!["obtenerCategorias"];
          categoriasD.forEach((data) {
            categorias.add(Categoria.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["categorias"]=categorias;
    return map;
  }

  @override
  Future<bool> registrarMuchasCategorias(List<String> nombres_categorias) async{
    List datos=[];
    nombres_categorias.forEach((element) { 
      datos.add({"nombre_categoria":element});
    });
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarMuchasCategorias()),
        variables: (
          {"input":datos}
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    return completado;
  }
}