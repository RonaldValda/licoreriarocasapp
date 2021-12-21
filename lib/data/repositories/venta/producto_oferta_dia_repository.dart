import 'package:licoreriarocasapp/data/repositories/venta/producto_oferta_dia_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/producto_oferta_dia.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_venta.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';

class ProductoOfertaDiaRepository extends AbstractProductoOfertaDia{
  @override
  Future<Map<String, dynamic>> eliminarProductoOfertaDia(String id) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarProductoOfertaDia()),
        variables: (
          {
            "id":id
          }
        ),
        onCompleted: (data){
          if(data!=null){
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          error.graphqlErrors.forEach((e) { 
            mensajeError=e.message;
          });
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> modificarProductoOfertaDia(ProductoOfertaDia productoOfertaDia) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarProductoOfertaDia()),
        variables: (
          productoOfertaDia.toMap()
        ),
        onCompleted: (data){
          if(data!=null){

          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          error.graphqlErrors.forEach((e) { 
            mensajeError=e.message;
          });
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarProductoOfertaDia(ProductoOfertaDia productoOfertaDia) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarProductoOfertaDia()),
        variables: (
          productoOfertaDia.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            productoOfertaDia.id=data["registrarProductoOfertaDia"]["id"];
          }
        },
        onError: (error){
          error!.graphqlErrors.forEach((e) { 
            mensajeError=e.message;
          });
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerProductoOfertaDia(String idProducto, String fecha) async{
    Map<String,dynamic> map={};
    ProductoOfertaDia productoOfertaDia=ProductoOfertaDia.vacio();
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerProductoOfertaDia()),
        variables: ({
          "producto":idProducto,"fecha":fecha
        }),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      mensajeError=result.exception!.graphqlErrors[0].message;
      print(mensajeError);
      completado=false;
    }else if(!result.hasException){
      print(result.data);
      if(result.data!["obtenerProductoOfertaDia"]!=null){
          productoOfertaDia=ProductoOfertaDia.fromMap(result.data!["obtenerProductoOfertaDia"]);
      }
    }
    map["completado"]=completado;
    map["producto_oferta_dia"]=productoOfertaDia;
    map["mensaje_error"]=mensajeError;
    return map;
  }

}