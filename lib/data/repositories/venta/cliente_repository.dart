import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/venta/cliente_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/cliente.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_venta.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class ClienteRepository extends AbstractClienteRepository{
  @override
  Future<Map<String, dynamic>> eliminarCliente(String id) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarCliente()),
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
  Future<Map<String, dynamic>> modificarCliente(Cliente cliente) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarCliente()),
        variables: (
          cliente.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
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
  Future<Map<String, dynamic>> obtenerClientes() async{
    Map<String,dynamic> map={};
    List<Cliente> clientes=[];
    List clientesD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerClientes()),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
        if(result.data!["obtenerClientes"]!=null){
          clientesD=result.data!["obtenerClientes"];
          clientesD.forEach((data) {
            clientes.add(Cliente.fromMap(data));
          });
      }
    }
    map["completado"]=completado;
    map["clientes"]=clientes;
    return map;
  }

  @override
  Future<Map<String, dynamic>> registrarCliente(Cliente cliente) async{
    Map<String,dynamic> map={};
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarCliente()),
        variables: (
          cliente.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            if(data["registrarCliente"]!=null){
              cliente.id=data["registrarCliente"]["id"];
            }
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
    map["cliente"]=cliente;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<Map<String, dynamic>> buscarCliente(String ciNit,String nombres) async{
    Map<String,dynamic> map={};
    List<Cliente> clientes=[];
    List clientesD=[];
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryBuscarCliente()),
        variables: ({
          "ci_nit":ciNit,"nombres":nombres
        }),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      mensajeError=result.exception!.graphqlErrors[0].message;
      completado=false;
    }else if(!result.hasException){
        if(result.data!["buscarCliente"]!=null){
          clientesD=result.data!["buscarCliente"];
          clientesD.forEach((data) {
            clientes.add(Cliente.fromMap(data));
          });
      }
    }
    map["completado"]=completado;
    map["clientes"]=clientes;
    return map;
  }

}