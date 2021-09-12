import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whollet_app/routes/routes.dart';

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({Key? key}): super(key:key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Color(0xFFEDF1F9),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 70),
            child: Stack(
              children: [
                Container(
                   padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      fontFamily: 'Titillium Web',
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF0D1F3C)
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  alignment: Alignment.topLeft,
                ),
                ],
            ),
          ),
                Container(
                  padding: EdgeInsets.only(top: 10,bottom: 200),
                  child: Text(
                    'Enter your registrated email address to receive \npassword reset instruction',
                    style: TextStyle(
                      fontFamily: 'Titillium Web',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      color: Color(0xFF485068),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: Stack(
                     children: [
                       Container(
                         decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                             topRight: Radius.circular(30.0),
                             topLeft: Radius.circular(30.0),
                        ),
                        color: Colors.white,
                      ),
                    ),
                       Padding(padding: const EdgeInsets.only(left:24.0,right: 60,top:30,bottom:24),
                         child: Column(
                         children: [
                           Container(
                             child: Center(
                               child: TextField(
                                 decoration: InputDecoration(
                                   hintText: "Email address",
                                 ),
                               ),
                             ),
                           ),
                           Container(
                             padding: EdgeInsets.only(top: 50),
                             child: ConstrainedBox(
                               constraints:
                               BoxConstraints.tightFor(width: 200,height: 46),
                               child: ElevatedButton(
                                 onPressed: () {
                                   Navigator.of(context).pushNamed(Routes.CheckYourEmail);
                                 },
                                 child: Text(
                                   'Reset Password',
                                   style: TextStyle(
                                     fontSize: 19,
                                     fontWeight: FontWeight.w600,
                                     fontFamily: 'Titillium Web',
                                   ),
                                   textAlign: TextAlign.center,
                                 ),
                                 style: ElevatedButton.styleFrom(
                                   primary: Color(0xFF347AF0),
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(30.0)
                                   )
                                 ),
                               )
                             )
                           )
                         ],
                       ),)
                  ],
                ),

                ),
        ],
      ),);
  }
}
