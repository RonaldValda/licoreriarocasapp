import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/producto/producto_kardex_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/producto.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_producto.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class ProductoKardexRepository extends AbstractProductoKardexRepository{
  @override
  Future<bool> eliminarProductoKardex(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarProductoKardex()),
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
  Future<bool> modificarProductoKardex(ProductoKardex productoKardex) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarProductoKardex()),
        variables: (
          productoKardex.toMap()
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
  Future<Map<String, dynamic>> obtenerProductoKardexs(String idProducto) async{
    Map<String,dynamic> map={};
    List<ProductoKardex> productoKardexs=[];
    List productoKardexsD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerProductoKardexs()),
        variables: ({
          "id_producto":idProducto
        }),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerProductoKardexs"]!=null){
          productoKardexsD=result.data!["obtenerProductoKardexs"];
          productoKardexsD.forEach((data) {
            productoKardexs.add(ProductoKardex.fromMap(data));
          });
      }
    }

    map["completado"]=completado;
    map["producto_kardexs"]=productoKardexs;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarProductoKardex(String idUsuario,String idSucursal,String idProducto,ProductoKardex productoKardex) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    Map<String,dynamic> mapVariables={};
    mapVariables.addAll(productoKardex.toMap());
    mapVariables.addAll({"id_usuario":idUsuario,"id_sucursal":idSucursal,"id_producto":idProducto});
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarProductoKardex()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            productoKardex.id=data["registrarProductoKardex"]["id"];
            productoKardex.fecha=data["registrarProductoKardex"]["fecha"];
            productoKardex.cantidadSaldo=data["registrarProductoKardex"]["cantidad_saldo"];
            productoKardex.valorSaldo=data["registrarProductoKardex"]["valor_saldo"];
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["producto_kardex"]=productoKardex;
    return map;
  }
}