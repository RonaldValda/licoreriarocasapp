import 'package:licoreriarocasapp/data/repositories/compra/compra_repository_gql.dart';
import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_compra.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class CompraRepository extends AbstractCompraReposity{
  @override
  Future<Map<String, dynamic>> registrarPreCompra(Compra compra,List<CompraProducto> compraProductos) async{
    Map<String,dynamic> map={};
    bool completado=true;
    Map<String,dynamic> mapVariables={};
    List cpsD=[];
    List compraProductosD=[];
    compraProductos.forEach((cp) { 
      cpsD.add(cp.toMap());
    });
    List<CompraProducto> cps=[];
    mapVariables.addAll(compra.toMap());
    mapVariables.addAll({"input_compra_productos":cpsD});
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarPreCompra()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            compraProductosD=data["registrarPreCompra"];
            compraProductosD.forEach((data) {
              CompraProducto cp=CompraProducto.fromMap(data);
              compraProductos.singleWhere((element) => false);
              cps.add(cp);
             });
            compra.id=data["registrarPreCompra"]["id"];
            compra.fechaPreCompra=data["registrarPreCompra"]["fecha_pre_compra"];
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["compra"]=compra;
    return map;
  }

  @override
  Future<bool> terminarPreCompra(Compra compra) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationTerminarPreCompra()),
        variables: (
          compra.toMap()
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
  Future<bool> modificarPreCompra(Compra compra) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarPreCompra()),
        variables: (
          compra.toMap()
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