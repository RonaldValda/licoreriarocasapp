import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:licoreriarocasapp/ui/pages/autenticacion/page_autenticacion.dart';
import 'package:licoreriarocasapp/ui/provider/Compra/compraProvider.dart';
import 'package:licoreriarocasapp/ui/provider/autenticacion/usuarioProvider.dart';
import 'package:licoreriarocasapp/ui/provider/generales/categoriasProvider.dart';
import 'package:licoreriarocasapp/ui/provider/productos/productosProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 //final HttpLink httpLink=new HttpLink("https://inmobiliaria-app-v1.herokuapp.com/");
  //final WebSocketLink webSocketLink=WebSocketLink("ws://inmobiliaria-app-v1.herokuapp.com/");
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>CategoriasProvider()),
        ChangeNotifierProvider(create: (_)=>ProductosProvider()),
        ChangeNotifierProvider(create: (_)=>UsuarioProvider()),
        ChangeNotifierProvider(create: (_)=>CompraProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white
                ),
                bodyText2: TextStyle(color: Colors.white),
                caption: TextStyle(color: Colors.red)
              )
            ),
            
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.black,
                fontSize: 18
              )
            ),
            primaryColor: Colors.white
      
          ),
          
          debugShowCheckedModeBanner: false,
          home: PageAutenticacion(),
        ),
    );
  }
}
