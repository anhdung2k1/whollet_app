import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whollet_app/UI/main_screen_ICX/body/background.dart';
import 'package:whollet_app/UI/main_screen_ICX/body/TextFieldContainer.dart';
import 'package:whollet_app/routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:whollet_app/UI/widgets/double_text.dart';
import 'package:whollet_app/UI/widgets/customer_info.dart';

class Body extends StatefulWidget {
  _Body createState() => _Body();
}
class _Body extends State<Body> {
  String uid = '';
  double _balance = 0;
  String _firstName = '', lastName = '', primaryKey = '', _address = '';
  bool _isBalance = false;
  final TextEditingController _ICXController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String status = "Transfer";
  void loadID() {
    if (uid == '')
      setState(() {
        print("Set IDDD");
        uid = FirebaseAuth.instance.currentUser!.uid;
      });
  }

  void loadData() {
    if (uid != '') {
      FirebaseFirestore.instance.collection('users').doc(uid).get().then(
            (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists && primaryKey == '') {
            setState(() {
              print(documentSnapshot.data());
              primaryKey = documentSnapshot.get('primary_key');
              _address = documentSnapshot.get('address');
              _firstName = documentSnapshot.get('first_name');
              lastName = documentSnapshot.get('last_name');
            });
          }
        },
      );
    }
  }

  void loadBalance() async {
    if (primaryKey != '') {
      final balance = await FlutterIconNetwork.instance!
          .getIcxBalance(privateKey: primaryKey);
      if (_balance != balance.icxBalance)
        setState(() {
          _balance = balance.icxBalance;
        });
    }
  }
  void showHideBalance()
  {
    setState(() {
      _isBalance = !_isBalance;
    });
  }
    String? addressWallet;
    String? privateKey;
    final _enterPrivateKey = TextEditingController();
    void _getWalletPrivateKey() async{
      final wallet = await FlutterIconNetwork.instance!.getWalletByPrivateKey(_enterPrivateKey.text);
      setState(() {
        privateKey = wallet?['private_key'];
        addressWallet = wallet?['address_key'];
      });
      Navigator.pushNamedAndRemoveUntil(context,Routes.CreateWalletKey,(route)=>false);
    }
    void _createWallet() async{
      final wallet = await FlutterIconNetwork.instance!.createWallet;
      setState(() {
        _enterPrivateKey.text = wallet.privateKey!;
      });
      _getWalletPrivateKey();
    }
  Future<void> transferICX() async {
    if (_formKey.currentState!.validate()) {
      print("ICX ${_ICXController.text}");
      print("Address ${_addressController.text}");
      setState(() {
        status = "Loadding";
      });
      final tHash = await FlutterIconNetwork.instance!.sendIcx(
          yourPrivateKey: primaryKey,
          destinationAddress: _addressController.text,
          value: _ICXController.text);
      _showTransferDialog(
        idTransaction: tHash.txHash.toString(),
        from: _address,
        to: _addressController.text,
        values: _ICXController.text,
        context: context,
      );
      setState(() {
        status = "Transfer";
        _ICXController.clear();
        _addressController.clear();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    loadID();
    loadData();
    loadBalance();
    return Background(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  CustomUserInfo(
                    pressCreateWallet: _createWallet,
                    balance: _balance,
                    isBalance: _isBalance,
                    firstName: _firstName,
                    lastName: lastName,
                    pressShowHide: showHideBalance,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              SvgPicture.asset("assets/ICX.svg",
                height: size.height * 0.3,),
              SizedBox(height: size.height * 0.03, width: size.width * 0.2,),
              TextFieldContainer(
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person, color: Color(0xFF6F35A5)),
                    hintText: "Destination Address",
                    border: InputBorder.none,
                  ),
                ),),
              TextFieldContainer(
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_balance_wallet_outlined,
                        color: Color(0xFF6F35A5)),
                    hintText: "Amount ICX Transfer"
                    ,),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints.tightFor(
                    height: 46,
                    width: 200,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.Login);
                    },
                    child: Text(
                      'Send ICX',
                      style: TextStyle(
                        fontFamily: 'Titillium Web',
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6F35A5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.0)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),)
    );
  }
}

Future<void> _showTransferDialog(
    {required String idTransaction,
      required String from,
      required String to,
      required String values,
      required BuildContext context}) async {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Transaction Details',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              DoubleText(title: 'Time', content: formattedDate),
              DoubleText(title: 'Total amount', content: values),
              DoubleText(title: 'Transaction ID', content: idTransaction),
              DoubleText(title: 'From', content: from),
              DoubleText(title: 'To', content: to),
              SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      padding: EdgeInsets.only(bottom: 60, right: 87,left: 88),
                      child: Stack(
                        children: [
                          Container(
                              child: ConstrainedBox(
                                constraints:
                                BoxConstraints.tightFor(width: 200,height: 46),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
              )
            ],
          ),
        ),
      );
    },
  );
}