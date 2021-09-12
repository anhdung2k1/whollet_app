import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:whollet_app/UI/constant/constant.dart';
import 'package:whollet_app/routes/routes.dart';
import 'package:flutter/gestures.dart';

class WelcomeScreen extends StatefulWidget{
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen>{
    Widget build(BuildContext context)
    {
      return Material(
        child: Stack(
          children: [
            Container(
              color: wPrimaryBlue,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 120),
                  child: Center(
                    child: SvgPicture.asset(
                        "assets/logo.svg",
                    ),
                  ),
                ),
                 Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Image.asset('assets/Welcome to WHOLLET.png'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 200),
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints.tightFor(width: 200,height: 50),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pushNamed(context, Routes.Login);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontFamily: 'Titillium Web',
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF347AF0)
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>
                        [
                          TextSpan(text: 'Don\'t have account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,),),
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.of(context).pushNamed(Routes.SignUp);
                            }
                            ),
                      ]
                    ),
                  )
                )
              ],
            )
          ],
        ),
      );
    }
}