import 'package:flutter/material.dart';
import 'package:whollet_app/UI/routes/theme/Welcome_screen.dart';
import 'package:whollet_app/Wallet_key/Create_wallet_key.dart';
import 'package:whollet_app/routes/routes.dart';
import 'package:whollet_app/UI/routes/Log_in/Login.dart';
import 'package:whollet_app/UI/routes/Authentication/EnterPin.dart';
import 'package:whollet_app/UI/routes/ForgotPassword/ForgotPassword.dart';
import 'package:whollet_app/UI/routes/Authentication/Check_Your_Email.dart';
import 'package:whollet_app/UI/routes/Sign_Up/SignUp.dart';
import 'package:whollet_app/UI/routes/Authentication/CreatePinConfirm.dart';
import 'package:whollet_app/UI/routes/Authentication/CreatePin.dart';
import 'package:whollet_app/UI/main_screen_ICX/main_screen_ICX.dart';

class RouteGenerator {
  static RouteGenerator? _instance;

  RouteGenerator._();

  factory RouteGenerator() {
    _instance ??= RouteGenerator._();
    return _instance!;
  }
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
      switch(settings.name){
        case Routes.WelcomeScreen:
          return MaterialPageRoute(builder: (_)=> WelcomeScreen());
        case Routes.Login:
          return MaterialPageRoute(builder: (_) => LogIn());
        case Routes.EnterPin:
          return MaterialPageRoute(builder: (_) => EnterPin());
        case Routes.ForgotPassword:
          return MaterialPageRoute(builder: (_) => ForgotPassword());
        case Routes.CheckYourEmail:
          return MaterialPageRoute(builder: (_) => CheckYourEmail());
        case Routes.SignUp:
          return MaterialPageRoute(builder: (_) => SignUp());
        case Routes.CreatePin:
          return MaterialPageRoute(builder: (_) => CreatePin());
        case Routes.CreatePinConfirm:
          return MaterialPageRoute(builder: (_) => CreatePinConfirm());
        case Routes.Begin:
          return MaterialPageRoute(builder: (_) => MainScreenICX());
        case Routes.CreateWalletKey:
          return MaterialPageRoute(builder: (_) => CreateWalletKey());
        default:
          return MaterialPageRoute(builder: (_) => WelcomeScreen());
      }
    }
}
