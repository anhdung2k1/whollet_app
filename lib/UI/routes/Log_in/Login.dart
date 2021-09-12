import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whollet_app/UI/constant/constant.dart';
import 'package:whollet_app/routes/routes.dart';

class LogIn extends StatefulWidget
{
  @override
  _LogInState createState() => _LogInState();
}
class _LogInState extends State<LogIn>
{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _status = '';
  final _formkey = GlobalKey<FormState>();
  bool flag = true;
  bool _passwordvisible = false;

  get loginProvider => null;
  void setFlag()
  {
    setState(() {
      flag = !flag;
    });
    if(flag)
      {
        FocusScope.of(context).requestFocus(FocusNode());
      }
  }
  Future<void> _checkLogin() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _status = '';
      });
      print('Email ${emailController.text}');
      print('Pass ${passwordController.text}');
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userCredential.user != null) {
          Navigator.pushNamed(context, Routes.EnterPin);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          setState(() {
            _status = 'No user found for that email.';
          });
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          setState(() {
            _status = 'Wrong password provided for that user.';
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }
  Widget build (BuildContext context)
  {
    bool _keyboardIsVisible() {
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }
    return Material(
      color: Color(0xFFEDF1F9),
      child: Column(
        children: [
          Container(
            key: _formkey,
            padding: EdgeInsets.only(top: 60.0),
            child: Center(
              child: Text(
                'Welcome Back!',
                style: TextStyle(
                  fontFamily: 'Titillium Web',
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(30.0),
            child: Image.asset("assets/login.png"),
          ),
          Expanded(child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    color: Colors.white,
                  ),
                ),
                AnimatedPositioned(
                  duration: kDefaultAnimation,
                    top: 12,
                    bottom: 257,
                    left: 24,
                    right: 24,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Center(
                          child: TextFormField(
                            controller: emailController,
                            validator: (val) => val!.isNotEmpty ? null : "Please enter a email address",
                            onTap: setFlag,
                            onEditingComplete: setFlag,
                            decoration: InputDecoration(
                              hintText: "Email address",
                            ),
                            style: TextStyle(fontSize: 19),
                          ),
                        )
                      ],
                  ),
                ),
                AnimatedPositioned(
                  duration: kDefaultAnimation,
                    top: 70,
                    bottom: 176,
                    right: 24,
                    left: 24,
                    child:  Stack(
                     children: [
                      Center(
                        child: TextFormField(
                          controller: passwordController,
                          validator: (val) => val!.length < 6 ? "Enter more than 6 char" : null,
                          onTap: setFlag,
                          onEditingComplete: setFlag,
                          obscureText: !_passwordvisible,
                          decoration:
                          InputDecoration(hintText: "Password"),
                          style: TextStyle(fontSize: 19),
                      ),
                    ),
                       Container(
                         alignment: Alignment.centerRight,
                         child: IconButton(
                           onPressed: () {
                             setState(() {
                               _passwordvisible = !_passwordvisible;
                             });
                           },
                           icon: Icon(
                             !_passwordvisible
                                 ? Icons.visibility_outlined
                                 : Icons.visibility_off_outlined,
                             color: Color(0xFFB5BBC9),
                           ),
                         ),
                       )
                  ],
                ),
                ),

                  Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.ForgotPassword);
                        },
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Titillium Web',
                            fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                ),
                AnimatedPositioned(
                  duration: kDefaultAnimation,
                  top: 200,
                  bottom: 80,
                  right: 87,
                  left: 88,
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                      BoxConstraints.tightFor(width: 200, height: 46),
                      child: ElevatedButton(
                        onPressed: () async{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                          setState(() {
                            _checkLogin();
                          });
                          Navigator.of(context).pushNamed(Routes.EnterPin);
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontFamily: 'Titillium Web',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF347AF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),

                    ),
                  ),
                ),
                Text(
                  _status,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                AnimatedPositioned(
                  duration: kDefaultAnimation,
                  top: 300,
                  bottom: 50,
                  right: 88,
                  left: 87,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Color(0xFF485068),
                        fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF347AF0),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            Navigator.of(context).pushNamed(Routes.SignUp);
                        }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
          ),
          ),
        ],
      ),
    );
  }
}
