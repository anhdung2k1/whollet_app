import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whollet_app/routes/routes.dart';
class CheckYourEmail extends StatefulWidget {
  const CheckYourEmail({Key ? key});
  @override
  _CheckYourEmailState createState()=> _CheckYourEmailState();
}
class _CheckYourEmailState extends State<CheckYourEmail>
{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
        color: Color(0xFFEDF1F9),
        child: Column(
         children: [
           Container(
             child: Stack(
               children: [
                 Positioned(
                    top: 60,
                    left: 32,
                    right: 32,
                    child: Text(
                  'Check Your Email',
                  style: TextStyle(
                    fontFamily: 'Titillium Web',
                     fontWeight: FontWeight.w600,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                  ),
                ),
                 Container(
                   padding: EdgeInsets.symmetric(vertical: 50),
                   child: IconButton(
                     onPressed: () {
                       Navigator.of(context).pop();
                     },
                     icon: Icon(Icons.arrow_back_ios),
                     iconSize: 24.0,
                   ),
                   alignment: Alignment.topLeft,
                 ),
                 Positioned(
                     top: 100,
                     left: 32,
                     right: 32,
                     child: Text(
                       'Follow a password recovery instructions we have just sent to your email address',
                       style: TextStyle(
                         fontFamily: 'Titillium Web',
                         fontWeight: FontWeight.w400,
                         fontSize: 15,
                       ),
                       textAlign: TextAlign.center,
                     )
                 )
                ],
              ),
             ),
              Spacer(),
              Center(
                child: Container(
                 width: 273,
                 height: 220,
                 child: Image.asset('assets/email.png'),
                ),
              ),
           Spacer(),
           Container(
             padding: EdgeInsets.only(bottom: 60, right: 87,left: 88),
             child: Stack(
               children: [
                 Container(
                   child: ConstrainedBox(
                     constraints:
                     BoxConstraints.tightFor(width: 200,height: 46),
                     child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.Login);
                        },
                        child: Text(
                          'Back To Login',
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
                     ),
                   )
                 )
               ],
             )
           )
            ],
           ),
        );
  }
}
