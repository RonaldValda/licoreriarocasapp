import 'package:licoreriarocasapp/data/repositories/compra/compra_producto_repository_gql.dart';
import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/domain/entities/compra.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_compra.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class CompraProductoRepository extends AbstractCompraProductoRepository{
  @override
  Future<Map<String, dynamic>> registrarCompraProducto(String idCompra,double costoTotal, CompraProducto compraProducto) async{
    Map<String,dynamic> map={};
    bool completado=true;
    Map<String,dynamic> mapVariables={};
    mapVariables.addAll(compraProducto.toMap());
    mapVariables.addAll({"id_compra":idCompra,"costo_total":costoTotal});
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarCompraProducto()),
        variables: (
          mapVariables
        ),
        onCompleted: (data){
          if(data!=null){
            compraProducto.id=data["registrarCompraProducto"]["id"];
          }
        },
        onError: (error){
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["compra_producto"]=compraProducto;
    return map;
  }

}