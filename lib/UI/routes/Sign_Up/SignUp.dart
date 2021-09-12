import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:whollet_app/routes/routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key ? key}) : super(key: key);
  @override
  _SignUpState createState()=> _SignUpState();
}
class _SignUpState extends State<SignUp>
{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool flag = false;
  String _status = '';
  bool _isvisiblePassword = false;
  void setFlag()
  {
    setState((){
      flag = !flag;
    });
    if(flag){
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
  Future<void> _checkSignUp() async {
    setState(() {
      _status = '';
    });
    if (_formkey.currentState!.validate()) {
      print("Email: ${emailController.text}");
      print("Email: ${passwordController.text}");
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (userCredential.user != null) {
          final wallet = await FlutterIconNetwork.instance!.createWallet;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid.toString())
              .set({
            'first_name': _firstNameController.text,
            'last_name': _lastNameController.text,
            'uid': userCredential.user!.uid.toString(),
            'email': emailController.text,
            'address': wallet.address,
            'primary_key': wallet.privateKey,
            'pin': {
              'pin': Crypt
                  .sha256('1234', rounds: 10000, salt: 'anhdung')
                  .hash
            },
          })
              .then((value) =>
          {Navigator.pushNamed(context, Routes.CreatePin)})
              .catchError((error) =>
          // ignore: invalid_return_type_for_catch_error
          print("Failed to add user: $error"));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            _status = 'The password provided is too weak.';
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _status = 'The account already exists for that email.';
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _keyboardIsVisible()
    {
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }
    return Material(
      color: Color(0xFFEDF1F9),
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 60,left: 100,right: 64),
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontFamily: 'Titillium Web',
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                top: 60,
                 child: IconButton(
                   onPressed: () {
                     Navigator.of(context).pushNamed(Routes.WelcomeScreen);
                   },
                    icon: Icon(Icons.arrow_back_ios),
                      iconSize: 24,
                    ),
                 ),
                Container(
                  padding: EdgeInsets.only(top: 147,left: 33,right: 34),
                  child:Container(
                    height: !_keyboardIsVisible() ? 171 : 171 - 102,
                    width: 308,
                    child: Image.asset('assets/office.png'),
                ),
                ),
              ],
            ),
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
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 24,right: 24),
                   child: TextFormField(
                     controller: _firstNameController,
                    validator: (val) => val!.isNotEmpty ? null : "Please Enter First Name",
                    onTap: setFlag,
                    onEditingComplete: setFlag,
                    decoration: InputDecoration(
                      hintText: "First Name",
                    ),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Titillium Web'
                    ),
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:20,left: 24,right: 24),
                    child: TextFormField(
                      controller: _lastNameController,
                      validator: (val) => val!.isNotEmpty ? null : "Enter last Name",
                      onTap: setFlag,
                      onEditingComplete: setFlag,
                      decoration: InputDecoration(
                        hintText: "Last Name",
                      ),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Titillium Web',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:20,left: 24,right: 24),
                    child: TextFormField(
                      controller: emailController,
                      validator: (val)=>val!.isNotEmpty ? null : "Enter email address",
                      onTap: setFlag,
                      onEditingComplete: setFlag,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Titillium Web',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:20,left: 24,right: 24),
                    child: TextFormField(
                      onTap: setFlag,
                      controller: passwordController,
                      validator: (val)=>val!.length < 6 ? "Enter more 6 char" : null,
                      onEditingComplete: setFlag,
                      obscureText: !_isvisiblePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Titillium Web',
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
                              _checkSignUp();
                              Navigator.of(context).pushNamed(Routes.CreatePin);
                            },
                            child: Text(
                              'Let\'s Get Started',
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
              ),
              Container(
                padding: EdgeInsets.only(top:90,right: 13),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isvisiblePassword = !_isvisiblePassword;
                        });
                      },
                      icon: Icon(!_isvisiblePassword ? Icons.visibility_outlined: Icons.visibility_off_outlined),
                      color: Color(0xFFB5BBC9)
                  )
              ),
            ],
          )),
              ],

            ),
          );
  }
}
