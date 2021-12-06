import 'package:graphql_flutter/graphql_flutter.dart';
class GraphQLConfiguration{
  //final HttpLink httpLink=new HttpLink("https://inmobiliaria-app-v1.herokuapp.com/");
  //final WebSocketLink webSocketLink=WebSocketLink("ws://inmobiliaria-app-v1.herokuapp.com/");
  final HttpLink httpLink=new HttpLink("http://192.168.100.5:4000/");
  final WebSocketLink webSocketLink=WebSocketLink("ws://192.168.100.5:4000/");
  //final Link link=httpLink.concat(webSocketLink);
  GraphQLClient myGQLClient(){
    return GraphQLClient(
      link: httpLink.concat(webSocketLink), 
      cache:  GraphQLCache(store: HiveStore())
    );
  }
}