import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/producto/producto_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_producto.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class ProductoRepository extends AbstractProductoReposytory{
  @override
  Future<bool> eliminarProducto(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarProducto()),
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
  Future<bool> modificarProducto(Producto producto) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarProducto()),
        variables: (
          producto.toMap()
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
  Future<Map<String, dynamic>> obtenerProductos(String idEtiqueta) async{
    Map<String,dynamic> map={};
    List<Producto> productos=[];
    List productosD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerProductos()),
        variables: ({
          "id_etiqueta":idEtiqueta
        }),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerProductos"]!=null){
          productosD=result.data!["obtenerProductos"];
          productosD.forEach((data) {
            productos.add(Producto.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["productos"]=productos;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerProductosGeneral() async{
    Map<String,dynamic> map={};
    List<Producto> productos=[];
    List productosD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerProductosGeneral()),
        variables: ({}),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerProductosGeneral"]!=null){
          productosD=result.data!["obtenerProductosGeneral"];
          productosD.forEach((data) {
            productos.add(Producto.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["productos"]=productos;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarProducto(String idEtiqueta, Producto producto) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables={};
    mapVariables.addAll(producto.toMap());
    mapVariables.addAll({"id_etiqueta":idEtiqueta});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarProducto()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            producto.id=data["registrarProducto"]["id"];
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["producto"]=producto;
    return map;
  }

  @override
  Future<Map<String, dynamic>> buscarProductoContenido(String contenido) async{
    Map<String,dynamic> map={};
    List<Producto> productos=[];
    List productosD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryBuscarProductoContenido()),
        variables: ({
          "contenido":contenido
        }),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["buscarProductoContenido"]!=null){
          productosD=result.data!["buscarProductoContenido"];
          productosD.forEach((data) {
            productos.add(Producto.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["productos"]=productos;
    return map;
  }

}