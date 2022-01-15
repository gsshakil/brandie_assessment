import 'package:brandie_assessment/apps/authentication/authentication_provider.dart';
import 'package:brandie_assessment/apps/core/landing_provider.dart';
import 'package:brandie_assessment/apps/core/splash_screen.dart';
import 'package:brandie_assessment/apps/favourites/favourite_provider.dart';
import 'package:brandie_assessment/apps/product/get_product_provider.dart';
import 'package:brandie_assessment/apps/product/product_provider.dart';
import 'package:brandie_assessment/general/routes/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final HttpLink httpLink = HttpLink("https://demo.saleor.io/graphql/");
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  var app = GraphQLProvider(
    client: client,
    child: const MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => GetProductProvider()),
        ChangeNotifierProvider(create: (_) => LandingProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
      ],
      child: MaterialApp(
        title: 'Brandy',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouterGenerator.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
