import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:whollet_app/routes/routes.dart';

class CreateWalletKey extends StatefulWidget{
  @override
  _CreateWalletKeyState createState() =>  _CreateWalletKeyState();
}
class _CreateWalletKeyState extends State<CreateWalletKey>{
  String? addressWallet;
  String? privateKey;
  final _enterPrivateKey = TextEditingController();
  void _getWalletPrivateKey2() async{
    final wallet = await FlutterIconNetwork.instance!.getWalletByPrivateKey(_enterPrivateKey.text);
    setState(() {
      privateKey = wallet?['private_key'];
      addressWallet = wallet?['address_key'];
    });
  }
  @override
  Widget build(BuildContext context) {
    final _enterPrivateKey = TextEditingController();
    return Material(
      child: Stack(
        children:<Widget> [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Colors.lightBlueAccent.withOpacity(0.3),
            ),
          ),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(bottom: 35),
                  child: Text('Private Key',
                  style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 35,
                  fontFamily: 'Titillium Web'
            ),
            ),
            ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.black38,
                        style: BorderStyle.solid),
                      bottom: BorderSide(
                        color: Colors.black38,
                        style: BorderStyle.solid
                        ),)),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 25,right: 25),
                           child: TextFormField(
                           controller: _enterPrivateKey,
                            minLines: 2,
                            maxLines: 4,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              hintText: "7d601f9d20703a97b8cb530538dbbadaa3e4bdfa5f333977e4232f51eebdc47a",
                              border: InputBorder.none,
                              enabledBorder:
                                InputBorder.none,
                              errorBorder:
                                InputBorder.none,
                              disabledBorder:
                                InputBorder.none
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                    padding: EdgeInsets.only(top: 50),
                    child: ConstrainedBox(
                        constraints:
                        BoxConstraints.tightFor(width: 200,height: 46),
                        child: ElevatedButton(
                          onPressed: () {
                            _getWalletPrivateKey2();
                            Navigator.of(context).pushNamed(Routes.Begin);
                          },
                          child: Text(
                            'Load Wallet',
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
                ),
          ],
        ),
      ],
      ),
    );
  }
}