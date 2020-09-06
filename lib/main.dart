import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/firebase/auth.dart';
import 'package:wvsu_tour_app/observers/default_block_observer.dart';
import 'package:wvsu_tour_app/screens/auth_screen.dart';
import 'package:wvsu_tour_app/screens/home_screen.dart';
import 'package:wvsu_tour_app/screens/legal_screen.dart';
import 'package:wvsu_tour_app/screens/root_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = DefaultBlocObserver();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  });
  @override
  Widget build(BuildContext context) {
    Auth appAuth = new Auth();
    return MaterialApp(
        home: new RootScreen(auth: appAuth),
        theme: ThemeData(
          primaryColor: appPrimaryColor,
          scaffoldBackgroundColor: appScaffoldBackgroundColor,
          textTheme:
              Theme.of(context).textTheme.apply(bodyColor: appTextBodyColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new AuthScreen(auth: appAuth),
          '/home': (BuildContext context) => new HomeScreen(),
          '/legal': (BuildContext context) => new LegalScreen(),
        });
  }
}
