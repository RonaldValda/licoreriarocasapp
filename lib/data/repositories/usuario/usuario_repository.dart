import 'package:licoreriarocasapp/data/repositories/configuration/configuracion_servidor_repository.dart';
import 'package:licoreriarocasapp/data/repositories/usuario/usuario_repository_gql.dart';
import 'package:licoreriarocasapp/domain/entities/usuario.dart';
import 'package:licoreriarocasapp/domain/repositories/abstract_usuario.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

class UsuarioRepository extends AbstractUsuarioRepository{
  @override
  Future<Map<String, dynamic>> autenticarUsuario(String email, String password,String medioRegistro) async{
    Map<String,dynamic> map={};
    Usuario usuario=Usuario.vacio();
    bool completado=true;
    String mensajeError="";
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationAutenticarUsuario()),
        variables: (
          {
            "email":email,
            "password":password,
            "medio_registro":medioRegistro
          }
        ),
        onCompleted: (data){
          if(data!=null){
            usuario.id=data["autenticarUsuario"]["id"];
            usuario=Usuario.fromMap(data["autenticarUsuario"]);
            usuario.email=email;
            usuario.medioRegistro=medioRegistro;
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
    map["usuario"]=usuario;
    map["mensaje_error"]=mensajeError;
    return map;
  }

  @override
  Future<bool> eliminarUsuario(String id) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationEliminarUsuario()),
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
  Future<bool> modificarUsuario(Usuario usuario) async{
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationModificarUsuario()),
        variables: (
          usuario.toMap()
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
  Future<Map<String, dynamic>> registrarUsuario(Usuario usuario) async{
    Map<String,dynamic> map={};
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    await client
    .mutate(
      graphql.MutationOptions(
        document: graphql.gql(getMutationRegistrarUsuario()),
        variables: (
          usuario.toMap()
        ),
        onCompleted: (data){
          if(data!=null){
            usuario.id=data["registrarUsuario"]["id"];
            usuario.fechaRegistro=data["registrarUsuario"]["fecha_registro"];
          }
        },
        onError: (error){
          print(error!.graphqlErrors[0].message);
          completado=false;
        }
      )
    );
    map["completado"]=completado;
    map["usuario"]=usuario;
    return map;
  }

  @override
  Future<Map<String, dynamic>> obtenerUsuarios() async{
    Map<String,dynamic> map={};
    Usuario usuario=Usuario.vacio();
    List<Usuario> usuarios=[];
    List usuariosD=[];
    bool completado=true;
    GraphQLConfiguration configuration=GraphQLConfiguration();
    graphql.GraphQLClient client=configuration.myGQLClient();
    graphql.QueryResult result=await client
    .query(
      graphql.QueryOptions(
        document:  graphql.gql(getQueryObtenerUsuarios()),
        fetchPolicy: graphql.FetchPolicy.cacheAndNetwork,
      ),
    );
    if(result.hasException){
      print(result);
      completado=false;
    }else if(!result.hasException){
      if(result.data!["obtenerUsuarios"]!=null){
        usuariosD=result.data!["obtenerUsuarios"];
        usuariosD.forEach((data) {
          usuarios.add(Usuario.fromMap(data));
        });
      }
    }
    map["completado"]=completado;
    map["usuarios"]=usuarios;
    return map;
  }

}