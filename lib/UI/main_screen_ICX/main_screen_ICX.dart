import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whollet_app/UI/main_screen_ICX/body/body.dart';
import 'package:whollet_app/routes/routes.dart';

class MainScreenICX extends StatefulWidget{
  @override
  _MainScreenICXState createState() => _MainScreenICXState();
}
class _MainScreenICXState extends State<MainScreenICX>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          child: Text("ICX Wallet",
            style: TextStyle(
            fontFamily: 'Titillium Web',
            fontWeight: FontWeight.w600,
            fontSize: 25,
              color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
        backgroundColor: Color(0xFF6F35A5).withOpacity(0.6),
        leading: Container(
          width: 80,
          child: PopupMenuButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://pbs.twimg.com/media/EvUPG1HUUAIMD-l?format=png&name=900x900"
              ),
            ), itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                  value: "Avatar",
                  child: Text('Méo Meo Meo Mèo'),
              ),
            ];
          },
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, Routes.Login);
          }, icon: Icon(Icons.logout), color: Colors.white.withOpacity(0.5),)
        ],
      ),
      body: Body(),
    );
  }
}

