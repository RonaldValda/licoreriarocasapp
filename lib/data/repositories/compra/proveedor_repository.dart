import 'package:licoreriarocasapp/data/repositories/compra/proveedor_repository_gql.dart';
import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/domain/entities/proveedor.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_compra.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class ProveedorRepository extends AbstractProveedorRepository{
  @override
  Future<Map<String, dynamic>> buscarProveedor(String ciNit, String nombres) async{
    Map<String,dynamic> map={};
    List<Proveedor> proveedores=[];
    List proveedoresD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryBuscarProveedor()),
        variables: ({
          "ci_nit":ciNit,
          "nombres":nombres
        }),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["buscarProveedor"]!=null){
          proveedoresD=result.data!["buscarProveedor"];
          proveedoresD.forEach((data) {
            proveedores.add(Proveedor.fromMap(data));
          });
      }
    }
    map["completado"]=completado;
    map["proveedores"]=proveedores;
    return map;
  }

  @override
  Future<bool> eliminarProveedor(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarProveedor()),
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
  Future<bool> modificarProveedor(Proveedor proveedor) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarProveedor()),
        variables: (
          proveedor.toMap()
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
  Future<Map<String, dynamic>> obtenerProveedores() async{
    Map<String,dynamic> map={};
    List<Proveedor> proveedores=[];
    List proveedoresD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerProveedores()),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerProveedores"]!=null){
          proveedoresD=result.data!["obtenerProveedores"];
          proveedoresD.forEach((data) {
            proveedores.add(Proveedor.fromMap(data));
          });
      }
    }
    map["completado"]=completado;
    map["proveedores"]=proveedores;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarProveedor(Proveedor proveedor) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarProveedor()),
        variables: (
          proveedor.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            proveedor.id=data["registrarProveedor"]["id"];
            proveedor.fechaRegistro=data["registrarProveedor"]["fecha_registro"];
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["proveedor"]=proveedor;
    return map;
  }

}