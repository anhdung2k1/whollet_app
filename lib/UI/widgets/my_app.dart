import 'package:flutter/material.dart';
import 'package:whollet_app/UI/routes/theme/Welcome_screen.dart';
import 'package:whollet_app/routes/RouteGenerator.dart';

class MyApp extends StatefulWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet_app',
      onGenerateRoute: RouteGenerator().onGenerateRoute,
      home: WelcomeScreen(),
    );
  }
}