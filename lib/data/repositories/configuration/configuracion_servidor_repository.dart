import 'package:graphql_flutter/graphql_flutter.dart';
class GraphQLConfiguration{
  final HttpLink httpLink=new HttpLink("https://licoreriarocasapp.herokuapp.com/");
  final WebSocketLink webSocketLink=WebSocketLink("ws://licoreriarocasapp.herokuapp.com/");
  //final HttpLink httpLink=new HttpLink("http://192.168.100.93:4000/");
  //final WebSocketLink webSocketLink=WebSocketLink("ws://192.168.100.93:4000/");
  //final Link link=httpLink.concat(webSocketLink);
  GraphQLClient myGQLClient(){
    return GraphQLClient(
      link: httpLink.concat(webSocketLink), 
      cache:  GraphQLCache(store: HiveStore())
    );
  }
}