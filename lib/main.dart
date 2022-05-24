import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokeapp/helper/dependency_injection.dart';
import 'package:pokeapp/pages/home_page.dart';

void main() {
  DependencyInjection.inicialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
